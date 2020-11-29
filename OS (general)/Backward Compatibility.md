* [Windows 10 and SafeDisc](#windows-10-and-safedisc)
* [MIDI Mapper](#midi-mapper)
* [Alt F4 doesn't terminate frozen applications](#alt-f4-doesnt-terminate-frozen-applications)

### Windows 10 and SafeDisc

SafeDisc games do not work on Windows 10 and restoring the ability to load SafeDisc protected games will make your OS vulnerable to several attacks.

* Extract a temporary location on the system.
* Copy `secdrv.sys` to `%WINDIR%\system32\drivers`.
* Import `secdrv.reg` to Windows registry.
* As the service may still not work due to lack of a [digital signature](https://windowsreport.com/driver-signature-enforcement-windows-10/), you need to disable it.


### MIDI Mapper

Microsoft officially removed the MIDI Mapper support in Windows 10. You can use [CoolSoft MIDIMapper instead](https://coolsoft.altervista.org/en/midimapper).


### Alt F4 doesn't terminate frozen applications

This is not OS related, some games utilize the Windows manager differently, as a alternative you can use[Super F4](https://stefansundin.github.io/superf4/).
