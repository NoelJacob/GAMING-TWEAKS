* [Meltdown/MDS/ZombieLoad Performance Impact (MUST READ!)](#meltdownmdszombieload-performance-impact-must-read)
* [NVIDIA's FPS limiters (V1, V2 & V3) vs RTSS vs In-engine](#nvidias-fps-limiters-v1-v2--v3-vs-rtss-vs-in-engine)
* [Hardware explained](#hardware-explained)
* [Windows Defender Exploit Guard Configuration](#windows-defender-exploit-guard-configuration)
* [HPET](#hpet)
* [General Research](#general-research)
* [Windows specific](#windows-specific)
* [Mouse & Keyboard](#mouse--keyboard)
* [Dithering under Windows](#dithering-under-windows)
* [NetCode, Networking](#netcode-networking)
* [Frametimes, FPS](#frametimes-fps)
* [TFT](#tft)
* [SSD](#ssd)
* [General Game tweak-knowledge](#general-game-tweak-knowledge)
* [YouTube Channel with focus on game analysis](#youtube-channel-with-focus-on-game-analysis)
* [YouTube Channel with focus on hardware analysis](#youtube-channel-with-focus-on-hardware-analysis)
* [Game Emulators](#game-emulators)
* [Game compatibility](#game-compatibility)
* [Raytracing benchmarks](#raytracing-benchmarks)
* [Official Forums](#official-forums)
* [DRM Performance Impact](#drm-performance-impact)
* [Other common DRM problems](#other-common-drm-problems)
* [Power Management](#power-management)
* [Kernel Latencies](#kernel-latencies)
* [PhysX](#physx)
* [Audio Latency in Windows](#audio-latency-in-windows)
* [For Developers](#for-developers)
* [RAID](#raid)
* [Driver & Firmware Resources](#driver--firmware-resources)
* [Legendary RAM OC Guides](#legendary-ram-oc-guides)
* [Comprehensive AMD Ryzen Memory & OC articles](#comprehensive-amd-ryzen-memory--oc-articles)
* [Comprehensive Intel "Coffee Lake" Memory & OC articles](#comprehensive-intel-coffee-lake-memory--oc-articles)
* [Message Signaled Interrupts](#message-signaled-interrupts)
* [AMD (AGESA) BIOS overview & download links](#amd-agesa-bios-overview--download-links)
* [Controller guides](#controller-guides)
* [Programs](#programs)
  * [Full Screen Optimizations](#full-screen-optimizations)
  * [USB Polling tools](#usb-polling-tools)
  * [HPET / QPC Benchmark tools](#hpet--qpc-benchmark-tools)
  * [Frametime capture and analysis tools](#frametime-capture-and-analysis-tools)
  * [Controller Emulators (_for Windows_)](#controller-emulators-for-windows)
  * [Monitor "OC" programs](#monitor-oc-programs)
  * [nVidia Driver "adjustment" programs](#nvidia-driver-adjustment-programs)
  * [Driver Uninstaller (leftover removal) programs](#driver-uninstaller-leftover-removal-programs)
  * [GPU OC programs (AMD/Intel/both)](#gpu-oc-programs-amdintelboth)
  * [AMD CPU OC programs](#amd-cpu-oc-programs)
  * [AMD AM4 Vcore VRM Ratings (Updated frequently)](#amd-am4-vcore-vrm-ratings-updated-frequently)
  * [AMD RAM OC programs](#amd-ram-oc-programs)
  * [AMD based OC tutorials](#amd-based-oc-tutorials)
  * [Intel "OC" programs](#intel-oc-programs)
  * [Internet Latency "tweak" programs](#internet-latency-tweak-programs)
  * [PC Latency measurement programs](#pc-latency-measurement-programs)
  * [Mouse "OC" programs](#mouse-oc-programs)
  * [Fix broken stereoscopic effects](#fix-broken-stereoscopic-effects)
  * [Power Management programs](#power-management-programs)
  * [Bios adjustment programs](#bios-adjustment-programs)
  * [Unpausable cutscenes](#unpausable-cutscenes)
  * [FOV calculator](#fov-calculator)
  * [GPU BIOS Updater tools](#gpu-bios-updater-tools)
* [Game streaming services](#game-streaming-services)
* [Virtual LAN Gaming](#virtual-lan-gaming)


## Meltdown/MDS/ZombieLoad Performance Impact (MUST READ!)
* [Looking At The Linux Performance Two Years After Spectre / Meltdown Mitigations (phoronix.com)](https://www.phoronix.com/scan.php?page=article&item=spectre-meltdown-2&num=1)
* [The Performance Impact Of MDS / Zombieload Plus The Overall Cost Now Of Spectre/Meltdown/L1TF/MDS (phoronix.com)](https://www.phoronix.com/scan.php?page=article&item=mds-zombieload-mit&num=1)
* [RAMBleed (rambleed.com)](https://rambleed.com/)
* [Network Cache ATtack (short: NetCAT) (vusec.net)](https://www.vusec.net/projects/netcat/) - [CVE-2019-11184](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11184)


## NVIDIA's FPS limiters (V1, V2 & V3) vs RTSS vs In-engine
- [Comprehensive benchmarking of NVIDIA's FPS limiters (V1, V2 & V3) vs RTSS vs In-engine: A research of their frame time consistency and approximate input lag.Software (r/allbenchmarks)](https://old.reddit.com/r/allbenchmarks/comments/fbuk9x/comprehensive_benchmarking_of_nvidias_fps/)


## Hardware explained
* [DDR4 vs GDDR5/GDDR6 vs LPDDR4 vs HBM2: Different Memory (RAM) Types Explained (hardwaretimes.com)](https://www.hardwaretimes.com/ddr4-vs-gddr5-gddr6-vs-lpddr4-vs-hbm2-different-memory-ram-types-explained/)


## Windows Defender Exploit Guard Configuration
* [Configure Windows Defender ExploitGuard, Reset all ProcessMitigation, Import clean recommended Baseline Configuration (github.com)](https://github.com/gunnarhaslinger/Windows-Defender-Exploit-Guard-Configuration)


## HPET
* [AMD and Intel Have Different HPET Guidance (anandtech.com)](https://www.anandtech.com/show/12678/a-timely-discovery-examining-amd-2nd-gen-ryzen-results/3)
* [AMD recommended HPET be disabled (realworldtech.com)](https://www.realworldtech.com/forum/?threadid=176149&curpostid=176160)
* [BCDEdit /set (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/bcdedit--set?redirectedfrom=MSDN)
* [Common Stutter / Lag / Crash Fix (HPET Guide) (linustechtips.com)](https://linustechtips.com/main/topic/915727-common-stutter-lag-crash-fix-hpet-guide/)
* [Disable High Precision Event Timer (HPET) in BIOS (forums.guru3d.com)](http://forums.guru3d.com/showpost.php?p=3770113&postcount=2)
* [Disable HPET(High Precision Event Timer) (mikemartin.co)](https://www.mikemartin.co/system_guides/hardware/motherboard/disable_high_precision_event_timer_hpet)
* [Disable or enable High Precision Event Timer(HTEP)? (bleepingcomputer.com)](https://www.bleepingcomputer.com/forums/t/677082/disable-or-enable-high-precision-event-timerhtep/)
* [Dynamic Tick Mode explained (doc.micrium.com)](https://doc.micrium.com/display/osiiidoc/Dynamic+Tick+Mode)
* [High Precision Event Timer (wikipedia.org)](https://en.wikipedia.org/wiki/High_Precision_Event_Timer)
* [How To Improve Gaming Performance By Disabling HPET Settings? (silicophilic.com)](https://silicophilic.com/disabling-hpet-settings/)
* [The Clock Tick (doc.micrium.com)](https://doc.micrium.com/display/osiiidoc/The+Clock+Tick)
* [Windows Timestamp (windowstimestamp)](https://www.windowstimestamp.com/description)


## General Research
* [A MINIMUM COMPLETE TUTORIAL OF CPU POWER MANAGEMENT, C-STATES AND P-STATES (metebalci.com)](https://metebalci.com/blog/a-minimum-complete-tutorial-of-cpu-power-management-c-states-and-p-states/)
* [ASUS PEG Link Mode Guide Rev. 2.0 (techarp.com)](http://www.techarp.com/showarticle.aspx?artno=248&pgno=0)
* [Better on the inside: under the hood of Windows 8 (arstechnica.com)](https://arstechnica.com/information-technology/2012/10/better-on-the-inside-under-the-hood-of-windows-8/2/)
* [Catalyst Antialiasing Guide (beyond3d.com)](http://www.beyond3d.com/content/articles/37/1)
* [Does Core i7 Hyper-Threading Helps? (vr-zone.com)](http://vr-zone.com/articles/does-core-i7-hyper-threading-helps-/6160.html?doc=6160)
* [Nvidia Inspector profile(s) to fix Low Power for some applications (github.com)](https://github.com/Ociidii-Works/Nvidia-GPU-Low-Power-Fix)
* [The Gigabyte GA-X48T-DQ6 - Redefining the High End? (anandtech.com)](http://www.anandtech.com/show/2410/13)


## Windows specific
* [Demystifying Fullscreen Optimizations (devblogs.microsoft.com)](https://devblogs.microsoft.com/directx/demystifying-full-screen-optimizations/)
* [Microsoft educates Insiders on how Windows 10 handles memory (onmsft.com)](https://www.onmsft.com/news/microsoft-educates-insiders-windows-10-handles-memory)
* [Windows 10 1809 Performance Impact (ict-r.com)](https://www.ict-r.com/windows-10-1809-performance-impact/)
* [Windows Vista's SuperFetch and ReadyBoost Analysed (tomshardware.com)](https://www.tomshardware.com/reviews/windows-vista-superfetch-and-readyboostanalyzed,1532-2.html)


## Mouse & Keyboard
* [Mouse Sensitivity (mouse-sensitivity.com)](https://www.mouse-sensitivity.com)
* [Wireless Mouse Click Latency Analysis (gamersnexus.net)](https://www.gamersnexus.net/guides/2594-wireless-mouse-click-latency-analysis-vs-wired)


## Dithering under Windows
* [Disable temporal dithering on Windows - Amulet Hotkey (resources.amulethotkey.com)](https://resources.amulethotkey.com/download/KBA_144_Disable_temporal_dithering_on_Windows_May_2018.pdf)


## NetCode, Networking
* [SYN cookies FAQ (cr.yp.to)](http://cr.yp.to/syncookies.html)


## Frametimes, FPS
* [GeDoSaTo FPS capping, modding controversies (blog.metaclassofnil.com)](http://blog.metaclassofnil.com/?p=715)


## TFT
* [TFT Central](https://www.tftcentral.co.uk/)


## SSD
* [TheSSDReview](http://www.thessdreview.com/)
* [The real and complete story - Does Windows defragment your SSD? (hanselman.com)](https://www.hanselman.com/blog/TheRealAndCompleteStoryDoesWindowsDefragmentYourSSD.aspx)


## General Game tweak-knowledge
* [PC Gaming Wiki (pcgamingwiki.com)](https://pcgamingwiki.com/wiki/Home) - Game configs, suggestions & tricks database (similar like Wikipedia just for games)
* [WSGF Forum (wsgf.org)](http://www.wsgf.org/forums/viewforum.php?f=64&sid=07479fb019fa626648795c596de5e9ea) - Game Mods, discussions and requests.


## YouTube Channel with focus on game analysis
* [Battle(non)sense](https://www.youtube.com/channel/UCP7QY6L5pvmm0-stL-pNFrw) (_net code and latency_)


## YouTube Channel with focus on hardware analysis
* [JayzTwoCents](https://www.youtube.com/user/Jayztwocents) (_all sorts of hardware_)
* [Gamers Neus](https://www.youtube.com/channel/UChIs72whgZI9w6d6FhwGGHA) (_all sorts of hardware_)
* [BitWid](https://www.youtube.com/channel/UCftcLVz-jtPXoH3cWUUDwYw) (_all sorts of hardware_)
* [TechSource](https://www.youtube.com/channel/UChIZGfcnjHI0DG4nweWEduw) (_all sorts of hardware_)
* [Rocket Jump Ninja](https://www.youtube.com/channel/UCGJaDZC7PChgd-XMwcbZkiw) (_mice_)


## Game Emulators
* [RetroArch (retroarch.com)](https://www.retroarch.com/)
* [Mesen high-accuracy NES and Famicom (mesen.ca)](https://www.mesen.ca/)
* [Snes9x (github.com)](https://github.com/snes9xgit/snes9x)
* [Higan (byuu.org)](https://www.byuu.org/emulation/higan/)
* [Emulator accuracy tests (tasvideos.org)](http://tasvideos.org/EmulatorResources.html#AccuracyTests)


## Game compatibility
* [dxwrapper](https://github.com/elishacloud/dxwrapper) - Fixes compatibility issues with older games running on Windows 10 by wrapping DirectX dlls. Also allows loading custom libraries with the file extension .asi into game processes.


## Raytracing benchmarks
* [Crytek Neon Noir](https://www.cryengine.com/marketplace/product/neon-noir#)


## Official Forums
* [Official nVidia Forum](https://forums.geforce.com/)
* [Official AMD Forum](https://community.amd.com/community/support-forums/general-discussion)
* [Official Intel Forum](https://forums.intel.com/s/?language=en_US)


## DRM Performance Impact
* [A non misleading benchmark of Denuvo in AC Origins](https://www.reddit.com/r/CrackWatch/comments/e6p6kc/a_non_misleading_benchmark_of_denuvo_in_ac_origins/) + [A 4c/4t benchmark of Denuvo in AC Origins [Follow up]](https://www.reddit.com/r/CrackWatch/comments/e73xb8/a_4c4t_benchmark_of_denuvo_in_ac_origins_follow_up/)
* [Resident Evil 2 Remake is faster by 4-12fps without the Denuvo anti-tamper tech (dsogaming.com)](https://www.dsogaming.com/news/resident-evil-2-remake-is-faster-by-4-12fps-without-the-denuvo-anti-tamper-tech/)
* [Denuvo Really Does Cripple PC Gaming Performance (https://www.extremetech.com)](https://www.extremetech.com/gaming/282924-denuvo-really-does-cripple-pc-gaming-performance)
* [Devil May Cry 5 PC's Denuvo DRM has a CPU hit (eurogamer.net)](https://www.eurogamer.net/articles/digitalfoundry-2019-devil-may-cry-5-pc-denuvo-protection-tested) - ([Updated test](https://www.techpowerup.com/reviews/Denuvo/Performance_Loss_Test/3.html))

## Other common DRM problems
* [Tron: Evolution SecuROM DRM expiration makes game unplayable 9 years after release (community.pcgamingwiki.com)](https://community.pcgamingwiki.com/topic/4476-tron-evolution-securom-drm-expiration-makes-game-unplayable-9-years-after-release/)


## Power Management
* [Device power management reference (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/device-power-management-reference)


## Kernel Latencies
* [User Mode Versus Kernel Mode (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/audio/user-mode-versus-kernel-mode)
* [Effectively Measure and Reduce Kernel Latencies for Real-time Constraints (elinux.org)](https://elinux.org/images/a/a9/ELC2017-_Effectively_Measure_and_Reduce_Kernel_Latencies_for_Real-time_Constraints_%281%29.pdf)
* [Analysis of High Resolution Timer Latency Using Kernel Analysis System in Embedded System (ieeexplore.ieee.org)](https://ieeexplore.ieee.org/document/4804584)
* [Acquiring high-resolution time stamps (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows/desktop/sysinfo/acquiring-high-resolution-time-stamps)
* [Example 15: Measuring DPC/ISR Time)](https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/example-15--measuring-dpc-isr-time)


## PhysX
* [Announcing NVIDIA PhysX SDK 5.0 (news.developer.nvidia.com)](https://news.developer.nvidia.com/announcing-nvidia-physx-sdk-5-0/)


## Audio Latency in Windows
* [Low Latency Audio (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/audio/low-latency-audio)
* [WavePci Latency (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/audio/wavepci-latency)
* [WaveCyclic Latency (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/audio/wavecyclic-latency)
* [Stream Latency During Recording (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/audio/stream-latency-during-recording)


## For Developers
* [Guidelines for Writing DPC Routines (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/guidelines-for-writing-dpc-routines)
* [Managing Input/Output for Drivers (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/managing-input-output-for-drivers?redirectedfrom=MSDN)
* [Scheduling Priorities (docs.microsoft.com)](https://docs.microsoft.com/en-us/windows/win32/procthread/scheduling-priorities?redirectedfrom=MSDN)


## RAID
* [Understanding RAID: How performance scales from one disk to eight (arstechnica.com)](https://arstechnica.com/information-technology/2020/04/understanding-raid-how-performance-scales-from-one-disk-to-eight/)


## Driver & Firmware Resources
* [8BitDo Firmware page (support.8bitdo.com)](http://support.8bitdo.com/)
* [Station-Drivers (station-drivers.com)](http://www.station-drivers.com/)
* [Standalone Steam Controller open source driver (github.com)](https://github.com/ynsta/steamcontroller)
* [Super Nt Official Firmware (support.analogue.co)](https://support.analogue.co/hc/en-us/articles/360000557452-Super-Nt-Firmware-Update-v4-7)
* [Super Nt Jailbreak (github.com)](https://github.com/SmokeMonsterPacks/Super-NT-Jailbreak)
* [Nt Mini Firmware Links (support.analogue.co)](https://support.analogue.co/hc/en-us/articles/115001947108-Nt-mini-Firmware-Update-v2-3)
* [Nt Mini Firmware Jailbreak (blog.kevtris.org)](http://blog.kevtris.org/blogfiles/ntm_firmware_verJB2.0.zip)
* [Mega Sg firmware (support.analogue.co)](https://support.analogue.co/hc/en-us/articles/360024836892-Mega-Sg-Firmware-Update-v4-2)
* [Mega SG Jailbreak (github.com)](https://github.com/SmokeMonsterPacks/Mega-Sg-Jailbreak)


## Comprehensive RAM OC Guides
* [RAM-Overclocking und Auswirkungen auf Spiele bei Intel CPUs (computerbase.de)](https://www.computerbase.de/forum/threads/intel-core-i-serie-ram-overclocking-auswirkungen-auf-spiele.1849970/)
* [Intel Skylake-X (Sockel 2066) OC-Guide (hardwareluxx.de)](https://www.hardwareluxx.de/community/f139/intel-skylake-x-sockel-2066-oc-guide-1172969.html)
* [AMD Ryzen - RAM OC Community (computerbase.de)](https://www.computerbase.de/forum/threads/amd-ryzen-ram-oc-community.1829356/)


## Comprehensive AMD Ryzen Memory & OC articles
* [The AnandTech Guide to Video Card Overclocking Software](https://www.anandtech.com/show/8589/anandtech-guide-to-video-card-overclocking-software/2)
* [AMD Ryzen Memory Tweaking & Overclocking Guide (techpowerup.com)](https://www.techpowerup.com/reviews/AMD/Ryzen_Memory_Tweaking_Overclocking_Guide/)
* [AMD RYZEN Overclocking Guide (overclockers.com)](https://www.overclockers.com/amd-ryzen-overclocking-guide/)
* [Official Corsair Ryzen 3000 Series Memory Overclocking Guide (corsair.com) (.pdf)](https://www.corsair.com/corsairmedia/sys_master/productcontent/Ryzen3000_MemoryOverclockingGuide.pdf)
* [Robert Hallock explains memory and overclocking on AMD Ryzen (youtube.com)](https://www.youtube.com/watch?v=vZgpHTaQ10k&feature=youtu.be&t=3m35s)


## Comprehensive Intel "Coffee Lake" Memory & OC articles
* [The Intel 9th Gen Review: Core i9-9900K, Core i7-9700K and Core i5-9600K Tested (anandtech.com)](https://www.anandtech.com/show/13400/intel-9th-gen-core-i9-9900k-i7-9700k-i5-9600k-review)
* [Intel's Core i9-9900K CPU reviewed (techreport.com)](https://techreport.com/review/34192/intel-core-i9-9900k-cpu-reviewed)


## Message Signaled Interrupts
* [Message Signaled Interrupts in PCI/PCIE : Advantages over INTx (blog.sasken.com)](https://blog.sasken.com/message-signaled-interrupts-in-pcipcie-advantages-over-intx)


## AMD (AGESA) BIOS overview & download links
* [AMD AGESA Bios collections thread (computerbase.de)](https://www.computerbase.de/forum/threads/sammelthread-amd-agesa-uebersicht-aller-bios-versionen.1902983/) - Overview of all AGESA BIOS updates, the website is in German but it's easy to understand, just follow your vendor and mobo and check if there is a link on the right side of the chart or not.

## Controller guides
- [Connect the Nintendo Switch Pro Controller to Windows](https://www.gameaccesory.com/post/how-to-connect-your-pro-controller-to-your-pc-infographic)

## Programs

### Full Screen Optimizations
* [Compatibility Manager (github.com)](https://github.com/Skymirrh/CompatibilityManager)

### USB Polling tools
* [USB polling precision explained (overclock.net)](https://www.overclock.net/forum/375-mice/1550666-usb-polling-precision.html)
* ~~[(old) Mouse tester tool (overclock.net)](https://www.overclock.net/forum/375-mice/1535687-mousetester-software.html) & [source code (github.com)](https://github.com/microe1/MouseTester)~~
* ~~([new) Mouse tester tool (overclock.net)](https://www.overclock.net/forum/375-mice/1590569-mousetester-software-reloaded.html) & [source code (github.com)](http://github.com/dobragab/MouseTester)~~
* [Mouse movement recorder by MarkC (donewmouseaccel.blogspot.com)](https://donewmouseaccel.blogspot.com/) & [Source Code](https://github.com/CHEF-KOCH/GamingTweaks/tree/master/Tools/Mouse%20Movement%20Recorder/MouseMovementRecorder%20Source%20Code)
* [Mouse Rate Checker (softpedia.com)](http://www.softpedia.com/get/System/System-Miscellaneous/Mouse-Rate-Checker.shtml)
* [1000hz - Overclock/Underclock your old mouse and increase its polling rate (github.com)](https://github.com/vadash/1000hz)

### HPET / QPC Benchmark tools
* [TimerBench](https://www.overclockers.at/downloads/projects/TimerBench%201.4.exe) ([source](https://www.overclockers.at/number-crunching/timerbench-ein-benchmark-fuer-windows-timer_249630/page_7))

### Frametime capture and analysis tools
* [CapFrameX (github.com)](https://github.com/DevTechProfile/CapFrameX)

### Controller Emulators (_for Windows_)
* [DualShock 4 for Windows (DS4Windows) (github.com)](https://github.com/Ryochan7/DS4Windows)
* [Xbox 360 Controller Emulator (x360ce.com)](https://www.x360ce.com/)

### Monitor "OC" programs
* [Custom Resolution Utility (CRU) (monitortests.com)](http://www.monitortests.com/forum/Thread-Custom-Resolution-Utility-CRU)
* [Pixelclock calculator (monitortests.com)](https://www.monitortests.com/pixelclock.php)

### nVidia Driver "adjustment" programs
* [nVidia Inspector (download.orbmu2k.de)](http://download.orbmu2k.de/files/nvidiaInspector.zip) + [source code](https://github.com/Orbmu2k/nvidiaProfileInspector) (latest final version) + [Latest beta](https://ci.appveyor.com/project/Orbmu2k/nvidiaprofileinspector)
* [NV RGBFullRangeToggle (blog.metaclassofnil.com)](http://blog.metaclassofnil.com/wp-content/uploads/2012/08/NV_RGBFullRangeToggle.zip) Use this tool if you don't see any 'Output dynamic range' option in the NVCP.

### Driver Uninstaller (leftover removal) programs
* [Display Driver Uninstaller (wagnardsoft.com)](https://www.wagnardsoft.com/)

### GPU OC programs (AMD/Intel/both)
* [MSI Afterburner + Guide (forums.guru3d.com)](https://forums.guru3d.com/threads/overclocking-with-msi-afterburner-at-users-risk.327291/)
* [AMD Memory Tweak (github.com)](https://github.com/Eliovp/amdmemorytweak)
* [Sapphire TriXX OC Utility (sapphiretech.com)](https://www.sapphiretech.com/en/software)
* [EVGA Precision XOC/X/X1 (evga.com)](https://www.evga.com/precisionxoc/)

### AMD CPU OC programs
* [AMD Ryzen Master (download.amd.com](https://download.amd.com/Desktop/AMD-Ryzen-Master.exe) + [Official FAQ](https://www.amd.com/en/support/kb/faq/gpu-775)
* [AmdMsrTweaker (github.com)](https://github.com/mpollice/AmdMsrTweaker)

### AMD AM4 Vcore VRM Ratings (Updated frequently)
- [AM4 Vcore VRM Ratings v1.4 (2019-11-07)](https://docs.google.com/spreadsheets/d/1d9_E3h8bLp-TXr-0zTJFqqVxdCR9daIVNyMatydkpFA/edit#gid=611478281)

### AMD RAM OC programs
* [Ryzen Timing Checker (techpowerup.com)](https://www.techpowerup.com/download/ryzen-timing-checker/)
* [DRAM Calculator for Ryzen (techpowerup.com)](https://www.techpowerup.com/download/ryzen-dram-calculator/)
* [ZenTiming](https://zentimings.protonrom.com/index.html)

### AMD based OC tutorials
* [How To Increase TDP Of Ryzen Based Laptops (Ryzen 5 3500U, 2500U...) - Ryzen Controller](https://youtu.be/4ekZRwxFFGU)

### Intel "OC" programs
* ~~[Intel® Extreme Tuning Utility - Intel® XTU](https://downloadcenter.intel.com/en/download/24075/Intel-Extreme-Tuning-Utility-Intel-XTU)~~ _Use other programs because the driver might cause performance problems._ Prefer (if possible) a method that does not require any software/driver e.b. via BIOS.
* ~~[Intel Power Maximizer](http://www.intel.com/performancemaximizer)~~

### Internet Latency "tweak" programs
* ~~[TCPOptimizer (speedguide.net)](http://www.speedguide.net/files/TCPOptimizer.exe)~~ _I do not recommend it_, tweak (manually) only parameters you [really need](https://github.com/CHEF-KOCH/GamingTweaks/issues/24).

### PC Latency measurement programs
* [LatencyMon (resplendence.com)](http://www.resplendence.com/latencymon)

### Mouse "OC" programs
* [Mouse Overclocking Utility (github.com)](https://github.com/vadash/1000hz)

### Fix broken stereoscopic effects
* [3Dmigoto (github.com)](https://github.com/bo3b/3Dmigoto) - Chiri's DX11 wrapper to enable fixing broken stereoscopic effects.

### Power Management programs
* [ClockBlocker (profiled AMD power-management control) (forums.guru3d.com)](https://forums.guru3d.com/threads/clockblocker-profiled-amd-power-management-control.404465/)

### Bios adjustment programs
* [BIOSTimingsDecoder](https://github.com/integralfx/BIOSTimingsDecoder)

### Unpausable cutscenes
* [Game Pauser](https://madebyjase.com/game-pauser/) (**Do NOT use it for online games, due to anti-cheat reasons**)

### FOV calculator
* [Online FOV calculator](https://themetalmuncher.github.io/fov-calc/)

### GPU BIOS Updater tools
* [Video Bios Collection](https://www.techpowerup.com/vgabios/)
* [AMDVbFlash](https://cdn.discordapp.com/attachments/529672908780339210/669884538335264788/AMDVbFlash_Win_v3.03.rar) also known as [AMD/ATI ATIFlash](https://www.techpowerup.com/download/ati-atiflash/) (_which is the old name_) + [Tutorial](https://www.gamersnexus.net/guides/3550-guide-how-to-flash-amd-gpu-vbios-rx-5600-xt)
* [nVidia NVFlash](https://www.techpowerup.com/download/nvidia-nvflash/) + [Tutorial](https://www.overclock.net/forum/69-nvidia/1523391-easy-nvflash-guide-pictures-gtx-970-980-a.html)


## Game streaming services
| Provider                                                                                                                        | Comment                                                                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Amazon Game Studios](https://www.amazongames.com/)                                                                             | //                                                                                                                                                                                |
| [Blade Shadow](https://shadow.tech/gben/discover?gclid=EAIaIQobChMI8qmCiYL94wIVVeDtCh3s_AAHEAAYASAAEgK8YPD_BwE)                 | Works with Mac, Android, iPhone, Ubuntu and Windows 10.                                                                                                                           |
| [Google Stadia](https://stadia.com/)                                                                                            | [Supported game list](https://store.google.com/de/product/stadia_games)                                                                                                           |
| [Twitch](https://www.twitch.tv/)                                                                                                | (_[planned for 2020](https://www.cnet.com/news/google-stadia-wants-to-be-the-future-of-gaming-so-do-microsoft-sony-and-amazon/)_)                                                 |
| [Parsec](https://parsecgaming.com/)                                                                                             | Play, watch, and share gaming with your friends in Parsec.                                                                                                                        |
| [GeForce Now](https://www.nvidia.com/en-gb/geforce/products/geforce-now/)                                                       | Play & Stream Android, PC, and GeForce NOW games.                                                                                                                                 |
| [Steam Link](https://store.steampowered.com/steamlink/about/) & [Steam Remote Play](https://store.steampowered.com/remoteplay/) | Stream video, audio, and voice between players while using your own controllers.                                                                                                  |
| [Moonlight](https://moonlight-stream.org/)                                                                                      | Play Your PC Games Remotely, [setup guide](https://github.com/moonlight-stream/moonlight-docs/wiki/Setup-Guide).                                                                  |
| [Rainway](https://rainway.com/)                                                                                                 | Allows you to launch all your PC games from one place on your home computer or stream through any browser, all completely free.                                                   |
| [PlayStation Now](https://www.playstation.com/en-gb/get-help/help-library/services/playstation-now/playstation-now-on-pc/)      | Stream PS2/PS3/PS4 games.                                                                                                                                                         |
| [Xbox Game Streaming (Microsoft: xCloud)](https://www.xbox.com/en-US/xbox-game-streaming)                                       | Stream your favorite Xbox games from the cloud or console straight to your Android phone or tablet.                                                                               |
| [Paperspace](https://www.paperspace.com/)                                                                                       | Fast cloud gaming in a web browser, [setup guide](https://blog.parsecgaming.com/setting-up-game-streaming-in-the-cloud-with-parsec-paperspace-just-got-a-lot-easier-bec072732bc9) |
| [Vortex Cloud Gaming](https://vortex.gg/?aff=6934464)                                                                           | Cloud Gaming for Android, PC and macOS.                                                                                                                                           |
| [Shadow](https://shadow.tech/dede/)                                                                                             | $35 per month, provides cloud gaming.                                                                                                                                             |
| [Magenta Gaming](https://magenta-gaming.telekom-dienste.de/)                                                                    | Telekom (ISP) only, requires a 50 Mbit/s connection.                                                                                                                              |


## Virtual LAN Gaming
| Provider                                                                       | Comment                                                                                                                             |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| [Hamachi](https://www.vpn.net/)                                                | Hosted VPN service that lets you securely extend LAN-like networks (Windows, Mac, Linux).                                           |
| [Tunngle](https://web.archive.org/web/20170606182108/https://www.tunngle.net/) | Freemium and closed source (last version 5.8.9 [30.Jun. 2017])                                                                      |
| [Evolve (Player.me)](https://player.me/)                                       | Inbuilt LAN support for almost all popular LAN games (Free, Party + $4.00/month)                                                    |
| [GameRanger](https://www.gameranger.com/download/)                             | GameRanger is definitely one of the best alternatives to Hamachi - Free, Silver Membership $19.95/year, Gold Membership $39.95/year |
| [Wippien](http://www.wippien.com/download.php)                                 | It connects PCs with a P2P connection - Free and open source                                                                        |
| [NetOverNet](https://www.netovernet.com/)                                      | Can be used as LAN emulator - Free, Basic $5/month, Advanced $10/month                                                              |
| [Radmin VPN](http://www.radmin-vpn.com/)                                       | Secure VPN tunnel that doesn't limit the number of users or gamers on its connection.                                             |
| [FreeLAN](http://www.freelan.org/download.html)                                | Almost no lag when playing games, a [tutorial is avaible here](https://www.freelan.org/get_help.html#adjusting-the-configuration)     |
| [P2PVPN](http://p2pvpn.org/)                                                   | P2PVPN is an open source developed with Java, the development has stopped in 2010.                                                  |
| [NetOverNet](https://www.netovernet.com/)                                      | NetOverNet is basically a simple VPN emulator that can be used for hosting private gaming session.                                  |
| [FreeLAN](http://www.freelan.org/download.html)                                | Completely open-source.                                                                                                             |
| [ZeroTier One](https://www.zerotier.com/download.shtml)                        | Open source, virtual systems are encoded end-to-end.                                                                                |
| [SoftEther VPN](https://www.softether.org/5-download)                          | SoftEther VPN can be used on Windows, Mac, Linux, Solaris, and FreeBSD operating systems.                                           |
| [Via WireGuard](https://wiki.archlinux.org/index.php/WireGuard)                | Simple yet fast and modern VPN that utilizes state-of-the-art cryptography.                                                         |

