{
==============================================================================
Copyright (C) 2006  anir (anir<AT>k.ro)

Modified 2013 - Mark Cranness:
- Work on Windows 7 when pointer speed < 6/11 or 'Enhance pointer precision' is set.
- Better matching of mouse movements to cursor movements.
- MUCH lower CPU use.
- Compiles with freepascal 3 http://www.freepascal.org/
	Command line to compile: fpc -Sd MouseMovementRecorder
- Work better on Windows 8.1.
- Correctly report mouse counts and pointer movement when per-monitor DPI scaling is on.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.
==============================================================================
}

{$apptype console}
{$r MouseMovementRecorder.rc}  // Avoid 'DPI Virtualisation' + Version info

uses
	Windows,
	DirectInput; // http://www.clootie.ru/delphi/DX92/Clootie_DirectX92.exe
	// Unrar and copy DirectInput.pas & DXTypes.pas from the Borland_D6-7\ folder
	// to same folder as MouseMovementRecorder.pas

const
	Caption0 = 'MOUSE MOVEMENT    POINTER MOVEMENT  FREQUENCY ';
	Caption1 = ' EnPtPr ' + #13;
	CaptionBlank = '                                                        ' + #13;
	ErrMsgPos = 'ERROR: GetCursorPos';
	ErrMsgPrfC = 'ERROR: QueryPerformanceCounter';
	ErrMsgPrfF = 'ERROR: QueryPerformanceFrequency';
	ErrMsgDIState = 'ERROR: DirectInput.GetDeviceState';
	FOREGROUND_WHITE = FOREGROUND_BLUE or FOREGROUND_GREEN or FOREGROUND_RED;

type
	MouseAccel = record
		MouseThreshold1 : integer;
		MouseThreshold2 : integer;
		MouseSpeed : integer;
	end;
	MovementExtraDetail = record
		TypeText : string;
		X, Y : integer;
		Time : Int64;
	end;
	CatchupModeEnum = (Auto, Always, NoCatchup);

type
	DPI_AWARENESS_CONTEXT = type THandle;
const
	DPI_AWARENESS_CONTEXT_UNAWARE          = DPI_AWARENESS_CONTEXT(-1);
	DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE= DPI_AWARENESS_CONTEXT(-3);

var
	DIMouDev: IDirectInputDevice8;
	DIMouDat, DIMouDat2 : DIMouseState;
	//PreviousMouDat, Previous2MouDat : DIMouseState;
	hMouseEvent: HANDLE;
	InputEvents : array[0..1] of HANDLE;
	InputEvent : DWORD;
	ConHdl, ErrHdl, StdInHdl, TmpLwd : HANDLE;
	OldPos, CurPos, OldExtraPos : TPoint;
	CursorX, CursorY: integer;
	PrfFrq, OldCnt, PrfCnt: Int64;
	PtrCatchup : Int64;
	MouseFrq: integer;
	Accel: MouseAccel;
	SeenEPP: boolean;
	CatchupDelay, DelayOK : integer;
	CatchupDelayIterations : integer;
	TryToCatchup : boolean;
	CatchupMode : CatchupModeEnum;
	ShowCatchupDelay, ShowCatchupLoops, ShowCatchupDelayEnabled, CatchupDelayExceeded : boolean;
	SetMaxTimerResolution : boolean;
	OSVersion : OSVERSIONINFO;
	CanSetDpiAwareness : boolean;
	NoCompatLayer : boolean;
	DpiAwareness : DPI_AWARENESS_CONTEXT;
	CP : integer; MicroSeconds, CatchupDelayText : string;
	Text, Param : string;
	i : integer;
	SkipNextParam : boolean;
	Not1To1, Not1To1Count, Is1To1Count, PrevNot1To1: integer;
	ShowExtraDetail : boolean;
	MovementExtraDetails : array of MovementExtraDetail;
	MovementExtraDetailsCount : integer;

label
	Loop, Ready;

function NtQueryTimerResolution(MinimumResolution, MaximumResolution, CurrentResolution: PULONG): word;
stdcall; external 'ntdll.dll';

function NtSetTimerResolution(DesiredResolution: ULONG; SetResolution: BOOLEAN; CurrentResolution: PULONG): word;
stdcall; external 'ntdll.dll';

procedure SetTimerResolutionMax(Max : boolean);
var
	TimerMinimumResolution, TimerMaximumResolution, TimerCurrentResolution : ULONG;
begin
	if not SetMaxTimerResolution then exit;
	NtQueryTimerResolution(@TimerMinimumResolution, @TimerMaximumResolution, @TimerCurrentResolution);
	if Max then
		// Set timer resolution to maximum so that Sleep(0) spins faster
		NtSetTimerResolution(TimerMaximumResolution, true, @TimerCurrentResolution)
	else
		NtSetTimerResolution(TimerMinimumResolution, false, @TimerCurrentResolution);
end;

// Int2Str from http://kolmck.net/ : avoid linking all of SysUtils
function IntToStr(Value: Integer): string;
var
	Buf: Array[0..15] of AnsiChar;
	Dst: PAnsiChar;
	Minus: Boolean;
	D: DWORD;
begin
	Dst := @Buf[15];
	Dst^ := #0;
	Minus := False;
	if Value < 0 then begin
		Value := -Value;
		Minus := True;
	end;
	D := Value;
	repeat
		Dec(Dst);
		Dst^ := AnsiChar((D mod 10) + Byte('0'));
		D := D div 10;
	until D = 0;
	if Minus then begin
		Dec(Dst);
		Dst^ := '-';
	end;
	Result := Dst;
end;

var
	OriginalMouseAccel : MouseAccel;
	OriginalMouseSensitivity : integer;
	ChangeMouseSensitivityWithAccel : boolean = true;

procedure SaveMouseSettings;
begin
	SystemParametersInfo(SPI_GETMOUSE, 0, @OriginalMouseAccel, 0);
	SystemParametersInfo(SPI_GETMOUSESPEED, 0, @OriginalMouseSensitivity, 0);
end;

procedure RestoreMouseSettings;
begin
	if OriginalMouseSensitivity > 0 then begin
		// Restore original mouse settings
		SystemParametersInfo(SPI_SETMOUSE, 0, @OriginalMouseAccel, 0);
		SystemParametersInfo(SPI_SETMOUSESPEED, 0, PVOID(OriginalMouseSensitivity), 0);
	end;
end;

function PointerSpeedSliderText(MouseSensitivity: integer): string;
begin
	if MouseSensitivity > 2 then begin
		PointerSpeedSliderText := IntToStr((MouseSensitivity div 2) + 1);
		if MouseSensitivity mod 2 > 0 then
			PointerSpeedSliderText += '.5';
	end else
		PointerSpeedSliderText := IntToStr(MouseSensitivity);
end;

function ConsoleHandler(cEvent: DWORD) : BOOL; stdcall;
begin
	RestoreMouseSettings();
	ConsoleHandler := false; // continue dieing
end;

procedure ErrorHalt(ErrMsg: string);
var
	Usage: string;
begin
	WriteFile(ConHdl, ErrMsg[1], Length(ErrMsg), TmpLwd, nil);
	WriteFile(ConHdl, (#13#10)[1], 2, TmpLwd, nil);
	Usage := 'Usage: MouseMovementRecorder [-NeverCatchup] [-AlwaysCatchup] [-MaxCatchupDelay <micro-seconds>] [-ShowCatchupDelay] [-ShowExtraDetail] [-NoCompatLayer] [-SetMaxTimerResolution]';
	WriteFile(ConHdl, Usage[1], Length(Usage), TmpLwd, nil);
	WriteFile(ConHdl, (#13#10)[1], 2, TmpLwd, nil);
	RestoreMouseSettings();
	Halt(1);
end;

function InitDI: Boolean;
var
	DInput: IDirectInput8;
begin
	hMouseEvent := CreateEvent(nil, false, false, nil);
	Result := (DirectInput8Create(hInstance, DIRECTINPUT_VERSION, IID_IDirectInput8, DInput, nil) = DI_OK)
		  and (DInput.CreateDevice(GUID_SysMouse, DIMouDev, nil) = DI_OK)
		  and (DIMouDev.SetDataFormat(c_dfDIMouse) = DI_OK)
		  and (DIMouDev.SetEventNotification(hMouseEvent) = DI_OK);
end;

const
	NoDTToDITMouseBatch = 'NoDTToDITMouseBatch';

// Read the Application Compatibility Shim Database and check that NoDTToDITMouseBatch is available.
function GetNoDTToDITMouseBatchLayerError : AnsiString;
const
	SDB_DATABASE_MAIN_SHIM = $80030000;
	TAGID_ROOT = 0;
	TAG_TYPE_STRINGREF = $6000;
	TAG_TYPE_LIST = $7000;
	TAG_DATABASE = $1 or TAG_TYPE_LIST;
	TAG_LAYER = $B or TAG_TYPE_LIST;
	TAG_NAME = $1 or TAG_TYPE_STRINGREF;

type
	TAG = WORD;
	TAGID = DWORD;
	PTAGID = ^TAGID;
	TAGREF = DWORD;
	THSDB = HANDLE;
	TPDB = Pointer;
	TPPDB = ^TPDB;
	TSdbInitDatabase = function(dwFlags: DWORD; pszDatabasePath: LPCWSTR) : THSDB; stdcall;
	TSdbTagRefToTagID = function(hSDB: THSDB; trWhich: TAGREF; ppdb: TPPDB; ptiWhichL: PTAGID) : BOOL; stdcall;
	TSdbFindFirstTag = function(pdb: TPDB; tiParent: TAGID; tTag: TAG) : TAGID; stdcall;
	TSdbFindNextTag = function(pdb: TPDB; tiParent: TAGID; tiPrev: TAGID) : TAGID; stdcall;
	TSdbReadStringTag = function(pdb: TPDB; tiWhich: TAGID; pwszBuffer: LPWSTR; cchBufferSize: DWORD) : BOOL; stdcall;

var
	AppHelpLib: HMODULE = 0;
	SdbInitDatabase: TSdbInitDatabase;
	SdbTagRefToTagID: TSdbTagRefToTagID;
	SdbFindFirstTag: TSdbFindFirstTag;
	SdbFindNextTag: TSdbFindNextTag;
	SdbReadStringTag: TSdbReadStringTag;
	HSdb: THSDB;
	Pdb: TPDB;
	DatabaseTag, LayerTag, NameTag: TAGID;
	Buffer, LayerName: WideString;

begin
	try
		AppHelpLib := LoadLibrary('apphelp.dll');
		if AppHelpLib = 0 then exit('Can''t load apphelp.dll');
		SdbInitDatabase := TSdbInitDatabase(GetProcAddress(AppHelpLib, 'SdbInitDatabase'));
		SdbTagRefToTagID := TSdbTagRefToTagID(GetProcAddress(AppHelpLib, 'SdbTagRefToTagID'));
		SdbFindFirstTag := TSdbFindFirstTag(GetProcAddress(AppHelpLib, 'SdbFindFirstTag'));
		SdbFindNextTag := TSdbFindNextTag(GetProcAddress(AppHelpLib, 'SdbFindNextTag'));
		SdbReadStringTag := TSdbReadStringTag(GetProcAddress(AppHelpLib, 'SdbReadStringTag'));
		if @SdbInitDatabase = nil then exit('Can''t find entry point in apphelp.dll');
		HSdb := SdbInitDatabase(SDB_DATABASE_MAIN_SHIM, nil);
		if HSdb = 0 then exit('Can''t init main application compatibility shim database.');
		SdbTagRefToTagID(HSdb, 0, @Pdb, @DatabaseTag);
		if Pdb = nil then exit('Can''t get main application compatibility shim database.');
		DatabaseTag := SdbFindFirstTag(Pdb, TAGID_ROOT, TAG_DATABASE);
		if DatabaseTag = 0 then exit('Can''t get main application compatibility shim database TAGID.');
		SetLength(Buffer, 256);
		LayerTag := SdbFindFirstTag(Pdb, DatabaseTag, TAG_LAYER);
		while LayerTag <> 0 do begin
			NameTag := SdbFindFirstTag(Pdb, LayerTag, TAG_NAME);
			SdbReadStringTag(Pdb, NameTag, PWideChar(Buffer), Length(Buffer));
			LayerName := Buffer;
			SetLength(LayerName, Length(PWideChar(LayerName)));
			if LayerName = NoDTToDITMouseBatch then exit(''); // Layer in place!
			LayerTag := SdbFindNextTag(Pdb, DatabaseTag, LayerTag);
		end;
		exit('Update for Windows 8.1 (KB2908279) is not installed.');
	finally
		if AppHelpLib <> 0 then FreeLibrary(AppHelpLib);
	end;
end;

// Ensure NoDTToDITMouseBatch application compatibility layer will prevent coalesced mouse pointer movement.
// Requires update http://support.microsoft.com/kb/2908279 or a superseding update installed.
procedure EnsureNoDTToDITMouseBatchLayer;
var
	NoDTToDITMouseBatchLayerError: AnsiString;
	BufferSize: integer;
	CompatLayer: AnsiString;
	StartInfo: STARTUPINFOA;
	ProcessInfo: PROCESS_INFORMATION;
begin
	// If Windows 8.1 or greater...
	if (OSVersion.dwMajorVersion < 6)
			or (OSVersion.dwMajorVersion = 6) and (OSVersion.dwMinorVersion < 3) then
		// Not Windows 8.1 or greater
		exit;

	// ...and NoDTToDITMouseBatch layer available...
	NoDTToDITMouseBatchLayerError := GetNoDTToDITMouseBatchLayerError();
	if NoDTToDITMouseBatchLayerError <> '' then begin
		SetConsoleTextAttribute(ErrHdl, FOREGROUND_WHITE or BACKGROUND_RED);
		WriteFile(ErrHdl, (#13#10)[1], 2, TmpLwd, nil);
		WriteFile(ErrHdl, NoDTToDITMouseBatchLayerError[1], Length(NoDTToDITMouseBatchLayerError), TmpLwd, nil);
		WriteFile(ErrHdl, (#13#10)[1], 2, TmpLwd, nil);
		NoDTToDITMouseBatchLayerError := 'Press ''+'' keyboard key press command until the red and green stops.';
		WriteFile(ErrHdl, NoDTToDITMouseBatchLayerError[1], Length(NoDTToDITMouseBatchLayerError), TmpLwd, nil);
		SetConsoleTextAttribute(ErrHdl, FOREGROUND_WHITE);
		WriteFile(ErrHdl, (#13#10)[1], 2, TmpLwd, nil);
		exit;
	end;

	// ...but NoDTToDITMouseBatch layer not applied...
	BufferSize := GetEnvironmentVariable('__COMPAT_LAYER', nil, 0);
	if BufferSize > 0 then begin
		SetLength(CompatLayer, BufferSize - 1);
		GetEnvironmentVariable('__COMPAT_LAYER', PChar(CompatLayer), BufferSize);
		if CompatLayer = NoDTToDITMouseBatch then
			exit; // Already have layer
	end;

	// Apply NoDTToDITMouseBatch and re-launch ourselves
	if not SetEnvironmentVariable('__COMPAT_LAYER', NoDTToDITMouseBatch) then
		exit;
	FillChar(StartInfo, SizeOf(StartInfo), 0);
	StartInfo.cb := SizeOf(StartInfo);
	FillChar(ProcessInfo, SizeOf(ProcessInfo), 0);
	if not CreateProcess(PChar(ParamStr(0)), PChar(GetCommandLine() + ' -nocompatlayer'),
			nil, nil, true, 0, nil, nil, StartInfo, ProcessInfo) then
		exit;

	// Wait until child MouseMovementRecorder exits
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
	Halt(0);
end;

// Ensure NoDTToDITMouseBatch application compatibility layer will prevent coalesced mouse pointer movement.
procedure EnsureNoDTToDITMouseBatchLayerOnWindows81;
begin
	// If Windows 8.1...
	if (OSVersion.dwMajorVersion = 6) and (OSVersion.dwMinorVersion = 3) then
		EnsureNoDTToDITMouseBatchLayer();
end;

function SetNextDpiAwareness() : string;
type
	TSetDpiAwareness = function(dpiContext: DPI_AWARENESS_CONTEXT) : DPI_AWARENESS_CONTEXT; stdcall;
var
	User32Lib: HMODULE = 0;
	SetThreadDpiAwarenessContext: TSetDpiAwareness;
begin
	try
		User32Lib := LoadLibrary('User32.dll');
		if User32Lib = 0 then exit('Can''t load User32.dll');
		SetThreadDpiAwarenessContext := TSetDpiAwareness(GetProcAddress(User32Lib, 'SetThreadDpiAwarenessContext'));
		if @SetThreadDpiAwarenessContext = nil then exit('Can''t find SetThreadDpiAwarenessContext in User32.dll');
		if DpiAwareness = DPI_AWARENESS_CONTEXT_UNAWARE then begin
			DpiAwareness := DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE;
			SetNextDpiAwareness := 'DPI Awareness = Per monitor DPI aware';
		end else begin
			DpiAwareness := DPI_AWARENESS_CONTEXT_UNAWARE;
			SetNextDpiAwareness := 'DPI Awareness = DPI unaware';
		end;
		SetThreadDpiAwarenessContext(DpiAwareness);
	finally
		if User32Lib <> 0 then FreeLibrary(User32Lib);
	end;
end;

procedure CaptureMovementExtraDetail(TypeText: string; X, Y: integer);
var
	PrfEvent: Int64;
	ExtraDetail: ^MovementExtraDetail;
begin
	if not QueryPerformanceCounter(PrfEvent) then ErrorHalt(ErrMsgPrfC);
	if Length(MovementExtraDetails) < MovementExtraDetailsCount+1 then
		SetLength(MovementExtraDetails, MovementExtraDetailsCount+1);
	ExtraDetail := @MovementExtraDetails[MovementExtraDetailsCount];
	MovementExtraDetailsCount += 1;
	ExtraDetail^.Time := PrfEvent - PrfCnt;
	ExtraDetail^.TypeText := TypeText;
	ExtraDetail^.X := X;
	ExtraDetail^.Y := Y;
end;

procedure PrintMovementExtraDetail;
var
	i: integer;
	ExtraDetail: ^MovementExtraDetail;
	ExtraDetailText: string;
begin
	for i := 0 to MovementExtraDetailsCount - 1 do begin
		ExtraDetail := @MovementExtraDetails[i];
		ExtraDetailText := ' @+' + IntToStr(ExtraDetail^.Time*1000000 div PrfFrq) + MicroSeconds
			+ ', ' + ExtraDetail^.TypeText
			+ ': ' + IntToStr(ExtraDetail^.X) + ' x ' + IntToStr(ExtraDetail^.Y);
		WriteFile(ConHdl, ExtraDetailText[1], Length(ExtraDetailText), TmpLwd, nil);
		WriteFile(ConHdl, (#13#10)[1], 2, TmpLwd, nil);
	end;
	WriteFile(ConHdl, (#13#10)[1], 2, TmpLwd, nil);
	MovementExtraDetailsCount := 0;
end;

procedure ShowKeyPressHelp;
var
	ToggleDpiAwareness: string = '';
begin
	if CanSetDpiAwareness then
		ToggleDpiAwareness := ' D : Toggle DPI awareness,' + #13#10;
	Text := #13#10
		+ 'Keyboard key press commands :' + #13#10#13#10
		+ ' A : Toggle ''Enhance pointer precision'' Acceleration,' + #13#10
		+ ' 1-9/* : Set pointer speed to n/11 (''/''=10/11, ''*''=11/11),' + #13#10
		+ ' 0 : Set pointer speed to Control Panel value,' + #13#10
		+ ' C : Toggle Catchup mode,' + #13#10
		+ ' + : Increase maximum catchup delay,' + #13#10
		+ ' - : Decrease maximum catchup delay,' + #13#10
		+ ' S : Toggle showing of catchup delay,' + #13#10
		+ ' L : Toggle showing of catchup delay loops,' + #13#10
		+ ' E : Toggle showing of extra detail,' + #13#10
		+ ToggleDpiAwareness
		+ ' Esc or Q : Exit' + #13#10#13#10;
	WriteFile(ErrHdl, CaptionBlank[1], Length(CaptionBlank), TmpLwd, nil);
	WriteFile(ErrHdl, Text[1], Length(Text), TmpLwd, nil);
end;

procedure ProcessCommandKey;
var
	InputRecord: INPUT_RECORD;
	EventCount: DWORD;
	Command: char;
	CommandResultText: string;
	MouseSensitivity : integer;
begin
	repeat
		PeekConsoleInput(StdInHdl, @InputRecord, 1, @EventCount);
		if EventCount = 0 then break;
		ReadConsoleInput(StdInHdl, @InputRecord, 1, @EventCount);
		if (InputRecord.EventType = KEY_EVENT)
				and InputRecord.Event.KeyEvent.bKeyDown
				and (Ord(InputRecord.Event.KeyEvent.AsciiChar) <> 0) then begin
			Command := LowerCase(InputRecord.Event.KeyEvent.AsciiChar);
			CommandResultText := '';

			if Command = 'a' then begin

				// Toggle Accel on and off
				SystemParametersInfo(SPI_GETMOUSE, 0, @Accel, 0);
				if Accel.MouseSpeed > 0 then begin
					Accel.MouseSpeed := 0;
					MouseSensitivity := 10;
					CommandResultText := 'EnPtPr Accel = Off';
				end else begin
					Accel.MouseSpeed := 1;
					MouseSensitivity := OriginalMouseSensitivity;
					CommandResultText := 'EnPtPr Accel = ON';
					SeenEPP := true;
				end;
				if not ChangeMouseSensitivityWithAccel then
					SystemParametersInfo(SPI_GETMOUSESPEED, 0, @MouseSensitivity, 0);
				CommandResultText += ', Pointer speed = ' + PointerSpeedSliderText(MouseSensitivity) + '/11';
				SystemParametersInfo(SPI_SETMOUSE, 0, @Accel, 0);
				if ChangeMouseSensitivityWithAccel then
					SystemParametersInfo(SPI_SETMOUSESPEED, 0, PVOID(MouseSensitivity), 0);

			end else if ('0' <= Command) and (Command <= '9') or (Command = '/') or (Command = '*') then begin
				// Set mouse pointer speed slider/sensitivity
				if Command = '/' then MouseSensitivity := 18 // 10/11
				else if Command = '*' then MouseSensitivity := 20 // 11/11
				else if Command = '0' then MouseSensitivity := OriginalMouseSensitivity
				else if Command <= '2' then MouseSensitivity := Ord(Command) - Ord('0')
				else MouseSensitivity := 2*(Ord(Command) - Ord('0')) - 2;
				SystemParametersInfo(SPI_SETMOUSESPEED, 0, PVOID(MouseSensitivity), 0);
				CommandResultText := 'Pointer speed = ' + PointerSpeedSliderText(MouseSensitivity) + '/11';
				// '0' (zero) command stops us changing pointer speed when we change accel
				if Command = '0' then ChangeMouseSensitivityWithAccel := not ChangeMouseSensitivityWithAccel;

			end else if (Command = 'c')
					and (InputRecord.Event.KeyEvent.dwControlKeyState and (LEFT_ALT_PRESSED or RIGHT_ALT_PRESSED) <> 0)then begin
				// Enable _C_ompat layer, or make Get_C_ursorPos work
				EnsureNoDTToDITMouseBatchLayer();

			end else if (Command = 'c') or (Command = 's') or (Command = 'l') or (Command = '+') or (Command = '-') then begin
				// Toggle modes
				if Command = 'c' then begin
					if CatchupMode = Auto then
						CatchupMode := Always
					else if CatchupMode = Always then
						CatchupMode := NoCatchup
					else
						CatchupMode := Auto;
					SetTimerResolutionMax(CatchupMode <> NoCatchup);
					TryToCatchup := CatchupMode <> NoCatchup;
				end else if Command = 's' then
					ShowCatchupDelayEnabled := not ShowCatchupDelayEnabled
				else if Command = 'l' then begin
					ShowCatchupLoops := not ShowCatchupLoops;
					ShowCatchupDelayEnabled := ShowCatchupDelayEnabled or ShowCatchupLoops;
				end else if (Command = '+') or (Command = '-') then begin
					if Command = '+' then CatchupDelay *= 2
					else if CatchupDelay > 500 then CatchupDelay := CatchupDelay div 2;
					CatchupMode := Always;
					SetTimerResolutionMax(true);
					TryToCatchup := true;
					ShowCatchupDelayEnabled := true;
				end;
				// Display current mode
				if CatchupMode = NoCatchup then
					CommandResultText := 'Catchup mode = NoCatchup'
				else begin
					if CatchupMode = Always then
						CommandResultText := 'Catchup mode = Always'
					else
						CommandResultText := 'Catchup mode = Auto';
					if ShowCatchupDelayEnabled then
						if ShowCatchupLoops then
							CommandResultText += ', Show catchup delay = loops'
						else
							CommandResultText += ', Show catchup delay = on'
					else
						CommandResultText += ', Show catchup delay = off';
					CommandResultText += ', Max catchup delay = ' + IntToStr(CatchupDelay) + MicroSeconds;
				end

			end else if Command = 'e' then begin
				ShowExtraDetail := not ShowExtraDetail;
				MovementExtraDetailsCount := 0;
				if ShowExtraDetail then
					CommandResultText := 'Show extra detail = on'
				else
					CommandResultText := 'Show extra detail = off'

			end else if (Command = 'd') and CanSetDpiAwareness then begin
				CommandResultText := SetNextDpiAwareness();

			end else if (Command = 'q') or (InputRecord.Event.KeyEvent.wVirtualKeyCode = VK_ESCAPE) then begin
				RestoreMouseSettings();
				Halt(0);

			end else begin
				ShowKeyPressHelp();

			end;

			if Length(CommandResultText) > 0 then begin
				WriteFile(ErrHdl, CaptionBlank[1], Length(CaptionBlank), TmpLwd, nil);
				SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE or BACKGROUND_GREEN);
				WriteFile(ConHdl, CommandResultText[1], Length(CommandResultText), TmpLwd, nil);
				SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE);
				WriteFile(ConHdl, (#13#10)[1], 2, TmpLwd, nil);
			end;
		end;
	until false;
end;

procedure ShowColumnTitles(Output: HANDLE);
begin
	WriteFile(Output, Caption0[1], Length(Caption0), TmpLwd, nil);
	if SeenEPP then SetConsoleTextAttribute(Output, FOREGROUND_WHITE or BACKGROUND_RED);
	WriteFile(Output, Caption1[1], Length(Caption1), TmpLwd, nil);
	if SeenEPP then SetConsoleTextAttribute(Output, FOREGROUND_WHITE);
end;

begin

	// Normal works best...
	//SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);

	OSVersion.dwOSVersionInfoSize := sizeof(OSVERSIONINFO);
	GetVersionEx(@OSVersion);
	CanSetDpiAwareness :=
		// On Windows 10 1607 or later only...
		(OSVersion.dwMajorVersion > 10)
			or (OSVersion.dwMajorVersion = 10)
				and ((OSVersion.dwMinorVersion > 0) or (OSVersion.dwBuildNumber >= 14393));

	// Output goes to the console (text)
	SetConsoleTitle('Mouse Movement Recorder');
	ConHdl := GetStdHandle(STD_OUTPUT_HANDLE);
	if ConHdl = INVALID_HANDLE_VALUE then ErrorHalt('ERROR: GetStdHandle');
	// Caption goes to stderr, so it does not end up in a file if we '>' redirect the output
	ErrHdl := GetStdHandle(STD_ERROR_HANDLE);
	if ErrHdl = INVALID_HANDLE_VALUE then ErrorHalt('ERROR: GetErrHandle');
	SetConsoleMode(ConHdl, ENABLE_PROCESSED_OUTPUT or ENABLE_WRAP_AT_EOL_OUTPUT);
	SetConsoleMode(ErrHdl, ENABLE_PROCESSED_OUTPUT or ENABLE_WRAP_AT_EOL_OUTPUT);
	StdInHdl := GetStdHandle(STD_INPUT_HANDLE);
	SetConsoleMode(StdInHdl, ENABLE_PROCESSED_INPUT); // No mouse or window

	// Process command line parameters
	CatchupMode := Auto; CatchupDelay := 500;
	ShowCatchupDelay := false; ShowCatchupLoops := false; ShowExtraDetail := false;
	SetMaxTimerResolution := false; NoCompatLayer := false;
	SkipNextParam := false;
	for i := 1 to ParamCount do begin
		if SkipNextParam then begin
			SkipNextParam := false;
			continue;
		end;
		Param := LowerCase(ParamStr(i));
		if Param = '-nocatchup' then begin
			CatchupMode := NoCatchup;
		end else if Param = '-alwayscatchup' then begin
			CatchupMode := Always;
		end else if Param = '-maxcatchupdelay' then begin
			if i >= ParamCount then ErrorHalt('ERROR: Missing -maxcatchupdelay value');
			Val(ParamStr(i+1), CatchupDelay, DelayOK);
			if DelayOK <> 0 then ErrorHalt('ERROR: Invalid -maxcatchupdelay value: ' + ParamStr(i+1));
			SkipNextParam := true;
		end else if Param = '-showcatchupdelay' then begin
			ShowCatchupDelayEnabled := true;
		end else if (Param = '-showextradetail') or (Param = '-showextradetails') then begin
			ShowExtraDetail := true;
		end else if (Param = '-setmaxtimerresolution') then begin
			SetMaxTimerResolution := true;
		end else if (Param = '-nocompatlayer') then begin
			NoCompatLayer := true;
		end else begin
			ErrorHalt('ERROR: Invalid parameter: ' + Param);
		end; 
	end;
	TryToCatchup := CatchupMode <> NoCatchup; Not1To1Count := 0; Is1To1Count := 0; PrevNot1To1 := 0;
	//PreviousMouDat.lX := 0; PreviousMouDat.lY := 0; Previous2MouDat := PreviousMouDat;

	if not NoCompatLayer then
		// Ensure NoDTToDITMouseBatch application compatibility layer will prevent coalesced mouse pointer movement
		EnsureNoDTToDITMouseBatchLayerOnWindows81();

	DpiAwareness := DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE; // Initialised in manifest

	// Initialise
	if not InitDI then ErrorHalt('ERROR: DirectInputCreate');
	if not QueryPerformanceFrequency(PrfFrq) then ErrorHalt(ErrMsgPrfF);
	if not QueryPerformanceCounter(OldCnt) then ErrorHalt(ErrMsgPrfC);
	if DIMouDev.Acquire <> DI_OK then ErrorHalt('ERROR: DirectInput.Acquire');
	if not GetCursorPos(OldPos) then ErrorHalt(ErrMsgPos);
	OldExtraPos := OldPos; MovementExtraDetailsCount := 0;
	SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE);
	SaveMouseSettings();
	SeenEPP := OriginalMouseAccel.MouseSpeed > 0;
	CP := GetConsoleOutputCP;
	if (CP = 437) or (CP = 850) or (CP = 858) then
		MicroSeconds := chr(230)+'s' // µs
	else
		MicroSeconds := 'us';

	// Set timer resolution to maximum so that Sleep(0) spins faster
	SetTimerResolutionMax(CatchupMode <> NoCatchup);

	SetConsoleCtrlHandler(@ConsoleHandler, true);

	ShowKeyPressHelp();
	ShowColumnTitles(ConHdl);
	WriteFile(ConHdl, (#10#00)[1], 1, TmpLwd, nil);

	// Flush FOCUS_EVENT from std input
	ProcessCommandKey; ResetEvent(StdInHdl);

	InputEvents[0] := StdInHdl;
	InputEvents[1] := hMouseEvent;

	Loop:

	// Get raw mouse data or keyboard data
	InputEvent := WaitForMultipleObjects(2, @InputEvents, false, INFINITE);

	if (InputEvent = WAIT_OBJECT_0) then begin
		ProcessCommandKey();
		goto Ready;
	end;

	if DIMouDev.GetDeviceState(SizeOf(DIMouDat), @DIMouDat) <> DI_OK then ErrorHalt(ErrMsgDIState);
	if not QueryPerformanceCounter(PrfCnt) then ErrorHalt(ErrMsgPrfC);
	if ShowExtraDetail then
		CaptureMovementExtraDetail('Mouse', DIMouDat.lX, DIMouDat.lY);
	ShowCatchupDelay := false; CatchupDelayExceeded := false; CatchupDelayIterations := 0;

	// Now wait (at most 0.5ms) for the pointer to catchup
	repeat
		// Get accelerated cursor (pointer) movement
		if not GetCursorPos(CurPos) then ErrorHalt(ErrMsgPos);
		// Calculate pointer movement based on old position
		CursorX := CurPos.X - OldPos.X;
		CursorY := CurPos.Y - OldPos.Y;
		if ShowExtraDetail
				and ((CurPos.X <> OldExtraPos.X) or (CurPos.Y <> OldExtraPos.Y)) then begin
			CaptureMovementExtraDetail('Pointer', CurPos.X - OldExtraPos.X, CurPos.Y - OldExtraPos.Y);
			OldExtraPos := CurPos;
		end;
		if not QueryPerformanceCounter(PtrCatchup) then ErrorHalt(ErrMsgPrfC);
		if (CatchupMode = NoCatchup)
				or not TryToCatchup and ((CursorX <> 0) or (CursorY <> 0))
				or (DIMouDat.lX = CursorX) and (DIMouDat.lY = CursorY) then
			// Pointer position has caught up (or we are not trying to catchup)
			break;
		ShowCatchupDelay := ShowCatchupDelayEnabled;
		if (PtrCatchup-PrfCnt)*1000000 > PrfFrq*CatchupDelay then begin
			// > 0.5ms
			CatchupDelayExceeded := true;
			break;
		end;
		// Don't be greedy during a busy wait
		Sleep(0);
		// ¿ Has there been some more mouse movement (SteelSeries Xai) ?
		if DIMouDev.GetDeviceState(SizeOf(DIMouDat2), @DIMouDat2) <> DI_OK then ErrorHalt(ErrMsgDIState);
		if ShowExtraDetail
				and ((DIMouDat2.lX <> 0) or (DIMouDat2.lY <> 0)) then
			CaptureMovementExtraDetail('Mouse', DIMouDat2.lX, DIMouDat2.lY);
		ResetEvent(hMouseEvent);
		DIMouDat.lX += DIMouDat2.lX;
		DIMouDat.lY += DIMouDat2.lY;
		CatchupDelayIterations += 1;
	until false;

	OldPos := CurPos;
	OldExtraPos := CurPos;

	// Display mouse movement
	WriteFile(ConHdl, (IntToStr(DIMouDat.lX) + ' x ' + IntToStr(DIMouDat.lY)
			  + '             ')[1], 18, TmpLwd, nil);

	// Display differences between mouse and pointer movement with red/green
	if (DIMouDat.lX <> CursorX) or (DIMouDat.lY <> CursorY) then begin
		if CursorX*CursorX + CursorY*CursorY > DIMouDat.lX*DIMouDat.lX + DIMouDat.lY*DIMouDat.lY then begin
			Not1To1 := +1;
			// Pointer > Mouse has a RED visual cue
			SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE or BACKGROUND_RED);
		end else begin
			Not1To1 := -1;
			// Pointer < Mouse has a GREEN visual cue
			SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE or BACKGROUND_GREEN);
		end;
		if (Not1To1 > 0) <> (Not1To1Count > 0) then Not1To1Count := 0;
		Not1To1Count += Not1To1;
		if abs(Not1To1Count) >= 3 then
			// 3 or more green in a row, or 3 or more red in a row (ignoring 1-to-1 lines):
			// STOP trying to catchup because it wastes CPU cycles for no reason
			TryToCatchup := CatchupMode = Always;
	end else begin
		Not1To1 := 0;
		if PrevNot1To1 <> 0 then Is1To1Count := 0;
		Is1To1Count += 1;
		if Is1To1Count >= 3 then begin
			// START trying to catchup because response is now 1-to-1
			TryToCatchup := CatchupMode <> NoCatchup;
			Not1To1Count := 0;
		end;
	end;
	PrevNot1To1 := Not1To1;

	// Display pointer movement
	WriteFile(ConHdl, (IntToStr(CursorX) + ' x ' + IntToStr(CursorY)
			  + '            ')[1], 17, TmpLwd, nil);
	SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE);

	// Display estimated mouse bus update frequency
	MouseFrq := Round(PrfFrq / (PrfCnt - OldCnt));
	OldCnt := PrfCnt;
	WriteFile(ConHdl, (' ~ ' + IntToStr(MouseFrq) + ' Hz    ')[1], 11, TmpLwd, nil);

	// Display Accel = MouseSpeed flag
	SystemParametersInfo(SPI_GETMOUSE, 0, @Accel, 0);
	if Accel.MouseSpeed > 0 then begin
		SeenEPP := true;
		SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE or BACKGROUND_RED);
		WriteFile(ConHdl, (' ON ')[1], 4, TmpLwd, nil);
		if Accel.MouseSpeed > 1 then begin
			Text := '(' + IntToStr(Accel.MouseSpeed) + ') ';
			WriteFile(ConHdl, (Text)[1], Length(Text), TmpLwd, nil);
		end;
		SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE);
	end else begin
		WriteFile(ConHdl, (' Off')[1], 4, TmpLwd, nil);
	end;

	if ShowCatchupDelay
			//and ((Is1To1Count >= 10) // We REALLY REALLY expect 1-to-1
			//	or (DIMouDat.lX*DIMouDat.lX + DIMouDat.lY*DIMouDat.lY > 2) // A large enough movement to expect pointer movement
			//		and (DIMouDat.lX*PreviousMouDat.lX >= 0) and (DIMouDat.lY*PreviousMouDat.lY >= 0)
			//		and (DIMouDat.lX*Previous2MouDat.lX >= 0) and (DIMouDat.lY*Previous2MouDat.lY >= 0)) // Haven't recently changed direction
			//and not (CatchupDelayExceeded and ((CursorX <> 0) or (CursorY <> 0))) then begin // We have seen SOME movement, but not 1-to-1
			then begin
		WriteFile(ConHdl, ('  ')[1], 1, TmpLwd, nil);
		if CatchupDelayExceeded then
			SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE or BACKGROUND_RED);
		CatchupDelayText := IntToStr((PtrCatchup-PrfCnt)*1000000 div PrfFrq) + MicroSeconds;
		if ShowCatchupLoops then 
			CatchupDelayText += ', ' + IntToStr(CatchupDelayIterations) + ' loops ';
		WriteFile(ConHdl, CatchupDelayText[1], Length(CatchupDelayText), TmpLwd, nil);
		SetConsoleTextAttribute(ConHdl, FOREGROUND_WHITE);
	end;

	//Previous2MouDat := PreviousMouDat;
	//if DIMouDat.lX <> 0 then PreviousMouDat.lX := DIMouDat.lX;
	//if DIMouDat.lY <> 0 then PreviousMouDat.lY := DIMouDat.lY;

	WriteFile(ConHdl, ('     ' + #13#10)[1], 7, TmpLwd, nil);

	if ShowExtraDetail then PrintMovementExtraDetail;

	Ready:

	// Display legend/caption at bottom
	ShowColumnTitles(ErrHdl);

	// Rinse and repeat (use Esc or Ctrl+C or Ctrl+Break to stop program)
	goto Loop;

end.