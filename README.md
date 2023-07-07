# Windows Gaming Tweaks

[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/fold_left.svg?style=social&label=Follow%20%40CHEF-KOCH)](https://twitter.com/CKsTechNews)
[![HitCount](http://hits.dwyl.com/NoelJacob/GAMING-TWEAKS.svg)](http://hits.dwyl.com/NoelJacob/GAMING-TWEAKS)

My little guide is all about Windows 10 Gaming (_and a little bit Linux!_) and I really mean gaming! There exist [tons of outdated guides and myths](https://github.com/CHEF-KOCH/GamingTweaks/blob/master/Known%20Myths.md) when it comes to "game tweaking" but they are mostly wrong, so I wrote my own guide to show the things which really do make the difference!


## General "tweak" advice
- [x] **Do not** use any `all-in-one tweak tools/programs or scripts`, it's not worth it.
- [x] **Do** always a **backups** of your current Windows 10 state. I recommend [Macrium Reflect](https://www.macrium.com/reflectfree) or (_FOSS & cross-platform_) [restic](https://github.com/restic/restic).
- [x] There is **no Voodoo tweak** or `regtweak.awesome.reg` which  increases your OS/Game performance like 50%.
- [x] **Do it yourself** and don't be lazy - _use brain.exe and do not copy tweaks from the internet!_.


#### This guide is not designed for:
- [x] Security / Virtual Machine (VM)
- [x] OS Hardening
- [x] Game only tweaks or modifications, you can [check nexusmods](https://www.nexusmods.com/) for this.
- [x] Older Windows 10 versions, we only list tweaks for the latest stable version.


#### Clarifications regarding the term "tweaking"
- [x] Tweaks usually do not magically increase any in-game FPS. There are specific circumstances in which the OS can be tweaked to improve or stabilize the game [smoothness](https://en.wikipedia.org/wiki/Smoothness), when you for example cap your FPS to get rid of the overheap which otherwise might have result in an in-game stuttering.
- [x] Tweaks should not be randomly applied via a "universal" script or tool because the OS itself changes over time and the configuration is different for each user. This is the reason why this project don't provide a general _"myawesomescript.ps1"_ script.
- [x] Tweaks are defined by: "Latency improvements", "Engine related improvements/workarounds", "FPS workarounds/fixes", "CPU usage" "RAM usage", "OS workarounds", "Driver workarounds" or "Network latency optimization". All of them can have an impact on the OS, game or network performance which means the OS/game might runs more _stable_ (_smooth_) or on higher fps (e.g. if overclocked or _optimized_).
- [x] [Known issues](https://docs.microsoft.com/en-us/windows/release-information/status-windows-10-2004) and possible workarounds do not count as tweaks, they are workarounds for problems Microsoft needs to fix.


#### Philosophy
- [x] Possible performance related problems should be reported directly to Microsoft, nVidia, AMD and/or the Game Develop Studio to address them so that everyone gets the same benefit. In terms of fair play it is [better](https://www.vice.com/en_us/article/43zdnb/battlefield-v-players-are-using-shitty-graphics-for-a-competitive-edge).
- [x] A _perfect OS_ does not need to be tweaked, the same goes for games but this will never happen due to several things e.g. bugs, different PC configurations, engine related problems and many more circumstances.
- [x] I do not claim to be the "tweak master" but I'm a long time experienced gamer and had the chance to get an insight into the Windows kernel (Windows XP - 7).


## Guide Index
* [BIOS Configuration and Tips](Bios/Readme.md)
* [OS (general)](OS%20(general)/Readme.md)
* [Hardware](Hardware%20(general)/Readme.md)
* [DirectX](DirectX/Readme.md)
* [Drivers](Drivers/Readme.md)
* [GPU AMD](GPU/AMD/Readme.md)
* [GPU nVidia](GPU/nVidia/Readme.md)
* [GPU and Shader in Games](GPU/Shader/Readme.md)
* [Monitor](Monitor/Readme.md)
* [Known Myths](Myths/Known%20Myths.md)
* [Mouse](Mouse/Readme.md)
* [Network](Network/Readme.md)
* [RAM](RAM/Readme.md)
* [SSD](SSD/Readme.md)
* [Retro Consoles](Retro%20Consoles/Readme.md)
* [Sound](Sound/Readme.md)
* [KB issue](KB%20problems/Readme.md)


## What Hardware should I buy?
* [Gamers hardware buyers guide](Hardware%20(general)/Gaming%20Hardware%20Buyer's%20Guide.md)


## Optional Topics & Tools
* [Overclocking](Overclocking/Readme.md)
* [Telemetry](Telemetry/Readme.md)
* [Tools to improve & analyse](Tools/Readme.md)
* [Registry](Registry/Readme.md)
* [OS Settings](OS%20Settings/Readme.md)
* [Awesome-Game-Networking](https://github.com/MFatihMAR/Awesome-Game-Networking)


## Gaming on Linux
* [Linux Gaming tweaks: short overview](Linux%20Gaming/Readme.md)


## Official Microsoft Docs related to gaming and OS performance
* [Tips to improve PC performance in Windows 10 by Microsoft](https://support.microsoft.com/en-us/help/4002019/windows-10-improve-pc-performance)
* [Scheduling, Thread Context, and IRQL](http://download.microsoft.com/download/e/b/a/eba1050f-a31d-436b-9281-92cdfeae4b45/IRQL_thread.doc)
* [Inside memory management](https://www.itprotoday.com/compute-engines/inside-memory-management-part-2)
* [Cache and Memory Manager Improvements](https://docs.microsoft.com/en-us/windows-server/administration/performance-tuning/subsystem/cache-memory-management/improvements-in-windows-server)


## Official Microsoft Docs related to Windows Support
* [Windows Health Dashboard](https://docs.microsoft.com/en-us/windows/release-information/status-windows-10-1903)
* [Windows lifecycle fact sheet](https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet)


## Negative tweak guide examples
* [Win 10 Guide (redacted.tv)](https://redacted.tv/2017/12/20/win10guide/) (_outdated_)
* [How To Tweak Windows 10 For Gaming (back2gaming.com)](http://www.back2gaming.com/guides/how-to-tweak-windows-10-for-gaming/) (_questionable recommendations_)
* [Gaming / PC Optimization / Useful Links & Apps (n1kobg.blogspot.com)](http://n1kobg.blogspot.com/) (_questionable recommendations_)
* [Youtuber: FR33THY Guide](https://docs.google.com/document/d/1nrcQ2EU5512TpuspPF4u5PgZ43p7hoV1cYBMi2C3XSQ/edit) [(video)](https://youtu.be/EG4g9XlKw5w) (_lots of claims with no evidence, interesting questions not getting answered or are off-topic_)


## Positive tweak guide examples
* [Mike Martin's Gaming tweaks (mikemartin.co)](http://www.mikemartin.co/gaming_guides)
* [Can You Get More Space Or Speed From Your SSD? (tomshardware.com)](https://www.tomshardware.com/reviews/ssd-performance-tweak,2911-4.html) + [SSD Optimization](https://wiki.debian.org/SSDOptimization)
* [Do we really need swap on modern systems? (redhat.com)](https://www.redhat.com/en/blog/do-we-really-need-swap-modern-systems)
* [Better Tear Control Policies, Game Capture, and GPU Improvements (docs.google.com)](https://docs.google.com/document/d/e/2PACX-1vRZkIJJCVynUPCqZbblmAIoPRx1rDIRLAV9CwjunyAaGm2YpIt_XsmiI8Tx4j_uMAaQ1UYrrWQClwUU/pub) + [Official Thread (forums.guru3d.com)](https://forums.guru3d.com/threads/better-tear-control-policies-game-capture-and-gpu-improvements.425331/)


## Project Research
* [Windows Gaming Tweaks Research](Research/Research.md)
