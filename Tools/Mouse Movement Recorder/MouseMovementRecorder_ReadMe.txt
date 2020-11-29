Mouse Movement Recorder

Copyright (C) 2006  anir
Modified 2015-2018 - Mark Cranness

Displays movements of the on-mouse-pad mouse and corresponding on-screen pointer movement.
Can be used to diagnose mouse pointer acceleration problems ('Enhance pointer precision').

Press Esc key to exit/stop.
Double-click window heading to Maximize window.

Mouse data displayed includes:

- MOUSE MOVEMENT   = X and Y mouse input (collected using DirectInput)
- POINTER MOVEMENT = Pointer movement (calculated from changes in pointer location)
- FREQUENCY = Sample rate / mouse bus update rate in Hz (="per second")
- EnPtPr    = Is the 'Enhance pointer precision' option turned ON?

If you run Mouse Movement Recorder in the background while running a game, it will
tell you if that game turns acceleration ('Enhance pointer precision') on.
When 'Enhance pointer precision' is on, the EnPtPr column displays a red ON.
If 'Enhance pointer precision' has been on at any time, the EnPtPr column at the
bottom of the window will display in red.
Turn 'Enhance pointer precision' OFF, run Mouse Movement Recorder, run your game,
then look at the EnPtPr column at the bottom of the Mouse Movement Recorder window.
If the EnPtPr has a red background, then your game turns 'Enhance pointer precision'
ON and needs a fix.

NOTE: While a game is running, Mouse Movement Recorder may show many red and green
lines, if the game continually re-positions the pointer to the middle of the screen.
Those red and green lines do NOT mean that you have acceleration, they only mean that
the re-positioned pointer has confused Mouse Movement Recorder.

NOTE: The FREQUENCY column is most accurate when the Catchup Mode is NoCatchup
(press 'C' key on keyboard until it displays 'Catchup mode = NoCatchup').
In other catchup modes, and when the 'Max catchup delay' is set higher (see '+' key
press command below), the FREQUENCY displayed might not be accurate.

If your system is busy, sometimes there might be an occasional delay before Windows 
updates the on-screen pointer position and if that happens the POINTER MOVEMENT will 
lag behind the MOUSE MOVEMENT.

COMMAND LINE OPTIONS / USAGE

MouseMovementRecorder [-NoCatchup] [-AlwaysCatchup] [-MaxCatchupDelay n] [-ShowCatchupDelay] [-ShowExtraDetail]  [-NoCompatLayer] [-SetMaxTimerResolution]

-NoCatchup
	Sometimes there is a small delay between mouse movement and Windows moving the
	on-screen pointer.
	By default, if MouseMovementRecorder sees mouse movement, but the corresponding
	pointer movement is not an exact 1-to-1 match, it may wait for up to 500 µs for
	additional pointer movement in case the pointer movement is delayed; It may wait
	for the pointer to 'catchup'.
	-NoCatchup tells MouseMovementRecorder to never wait for additional pointer
	movement, and report mouse movement immediately.

-AlwaysCatchup
	If MouseMovementRecorder sees 3 or more consecutive instances where the pointer
	movement is not an exact 1-to-1 match with the mouse movement, it will stop waiting
	for 'catchup'.
	-AlwaysCatchup tells MouseMovementRecorder to always wait for additional pointer
	movement when the corresponding pointer movement is not an exact 1-to-1 match.

-MaxCatchupDelay n
	How long to wait for a possible catchup. The default catchup wait is 500 µs (0.5 ms).

-ShowCatchupDelay
	Shows how long MouseMovementRecorder waited before the exact 1-to-1 catchup occured,
	or the delay exceeded the -maxcatchupdelay value.

-ShowExtraDetail
	Shows detail timing for the individual mouse movements and pointer movements that
	MouseMovementRecorder saw.

-NoCompatLayer
	On Windows 8.1 only, while MouseMovementRecorder is running, the KB2908279 Update
	for Windows 8.1 (Mouse pointer stutter fix) is activated (if it has been installed)
	to give more responsive mouse pointer movement.
	-NoCompatLayer tells MouseMovementRecorder NOT to activate the 'compatibility layer'
	that triggers the KB2908279 update fix.
	(On Windows 8.1 or 10, key press command Alt+C will also activate the update.)

-SetMaxTimerResolution
	Sets the Windows scheduling timer to its maximum resolution.

KEYBOARD KEY PRESS COMMANDS

While MouseMovementRecorder is running, keyboard command keys available are:

 A : Toggle 'Enhance pointer precision' Acceleration
 1-9/* : Set pointer speed to n/11 ('/'=10/11, '*'=11/11),
 0 : Set pointer speed to Control Panel value,
 C : Toggle Catchup mode
 + : Increase maximum catchup delay
 - : Decrease maximum catchup delay
 S : Toggle showing of catchup delay
 L : Toggle showing of catchup delay loops
 E : Toggle showing of extra detail
 D : Toggle DPI awareness, [Only on Windows 10 Version 1607 and later]
 Esc or Q : Exit
 
 On Windows 8.1 or 10, key press command Alt+C will activate the KB2908279 (Mouse pointer stutter fix) update.