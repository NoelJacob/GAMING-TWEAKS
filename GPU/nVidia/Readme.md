* [Nvidia FPS Limiter v3 vs RTSS](#nvidia-fps-limiter-v3-vs-rtss)
* [FreeSync Gaming on Nvidia (Adaptive Sync)](#freesync-gaming-on-nvidia-adaptive-sync)
* [Control Panel and it's toggles](#control-panel-and-its-toggles)
* [nVidia Shader Cache on a HDD](#nvidia-shader-cache-on-a-hdd)
* [How to get Windows 10 custom resolutions in any aspect ratio you want](#how-to-get-windows-10-custom-resolutions-in-any-aspect-ratio-you-want)
* [nVidia Deep Learning Super Sampling (short: DLSS)](#nvidia-deep-learning-super-sampling-short-dlss)

### Nvidia FPS Limiter v3 vs RTSS

Starting with [441.87](https://github.com/CHEF-KOCH/nVidia-modded-Inf/releases/tag/441.87) nVidia added their own FPS Limiter (v3) in the NV control panel. You might [ask yourself](https://youtu.be/W66pTe8YM2s) what are the differences between [RTSS](https://www.guru3d.com/files-details/rtss-rivatuner-statistics-server-download.html) and nVidia's solution and which solution should you prefer?

**Overall:**
- The frametime is more consistent with RTSS because this is how RTSS works.
- nVidia's solution does not allow you to change the frame rate without restarting the game, this works in RTSS. nVidia could fix or change that in the future.
- Every overlay you use, no matter what program will add a small delay!
- NVIDIA Inspector old limiter (v2) and AMDs Chill adding the most input delay.

**RTSS Pros:**
- _Nice_ GUI
- RTSS settings be be easily backuped
- Fractional limits (to reduce V-Sync input) can be set, no other tools allows that
- Allows to change per each game individual settings
- RTSS has global settings, and individual exe files settings

**Cons:**
- Adds a frame of [input delay](https://www.youtube.com/watch?v=rs0PYCpBJjc), to workaround it use the default ("Global" profile)
- It's an separate third-party tool which needs to run in the background
- Can interfere with steam's overlay feature
- Can crash specific games, depending on the settings and used injection method
- Some games will not start while injecting the overlay into it
- Some games can detect the injection method as "cheat" and disconnect or at worst, ban you!

**nVidia Frame Limiter Pros:**
- No third-party programs needed! Less background services are running.
- No per-game setting, you need to set the frame limit globally OR via the specific game profile which is a bit clunky

**Cons:**
- No _fancy_ GUI
- Not as advanced as RTSS
- Some games (once the limiter is enabled) having problems showing the in-game overlays


### FreeSync Gaming on Nvidia (Adaptive Sync)

Open the Nvidia Control Panel, browse to “Set up G-Sync”, then select your FreeSync monitor. From here, make sure both the “enable G-Sync, G-Sync compatible” checkbox and the “enable settings for the selected display model” checkbox are ticked. The second checkbox doesn’t appear if the monitor is G-Sync certified. Then click Apply, your monitor will restart and adaptive sync will be enabled.


### Control Panel and it's toggles

TweakGuides has a full documentation what each toggle/settings in the nVidia Control Panel (NVCP) does, I highly suggest that you read it before you touch any of the settings. The Guide constantly gets updates as soon nVidia changes something in the NVCP. The default settings are usually fine and you might only want to tweak the application/game settings related profiles, which you can do via the NVCP or [nVidia Inspector](https://github.com/DeadManWalkingTO/NVidiaProfileInspectorDmW) (unofficial utility).


### nVidia Shader Cache on a HDD

Shaders are loaded by the game itself, like any other of their assets, and sent to the driver for compilation (meaning transformed from source code form into binary form that can be used by the GPU.) The driver compiles them and sends the results back to the game. The compilation happens by the CPU, not the GPU, and is slow. A shader cache doesn't get rid of the loading-from-disk step. It only replaces the compilation step with a second loading step (loading the previously compiled form of the shader from disk and sending that to the game.) Even with a very slow disk, loading small already compiled shader files from said disk is much faster than generating them again. The shader cache is meant to persist between reboots. Putting them on a RAM disk meaning losing the cache on reboot - unless you're syncing the RAM disk to disk on reboot.


### How to get Windows 10 custom resolutions in any aspect ratio you want

[jim2point0](https://www.deadendthrills.com/forum/discussion/504/how-to-custom-aspect-ratios-and-resolutions-via-dsr-nvidia-only) wrote an excellent guide how to _optimize_ nVidia's DSR via registry in order to get any resolution you want.


### nVidia Deep Learning Super Sampling (short: DLSS)

If you're new to DLSS please [review the Wikipedia article first](https://en.wikipedia.org/wiki/Deep_Learning_Super_Sampling), you need minimum a nVidia a GeForce RTX 20 series GPU and Windows 10 (1809+) with the a nVidia driver higher than 445.75+.

[nVidia's new DLSS](https://www.nvidia.com/en-us/geforce/news/nvidia-dlss-2-0-a-big-leap-in-ai-rendering/) (2.0) [should be enabled in order to improve the overall game performance](https://www.youtube.com/watch?v=eS1vQ8JtbdM), especially if you use in-game ray-tracing. **You should** enable DLSS 2.0 (_if possible_), [MechWarrior 5: Mercenaries](https://youtu.be/RmSgJ3LJkvQ) and Control were one of the first games who actually benefit from the new DLSS 2.0 feature.

Specific whitepapers how DLSS works can be found over [here](https://www.gdcvault.com/play/mediaProxy.php?sid=1023870).

**Problems with DLSS 1.0**

* Blurry images and corners
* The image/game looks low-res
* Performance issues under specific circumstances compared to playing games without DLSS


**Introduction DLSS 2.0**

![DLSS 2.0 Performance Improvements](https://images.anandtech.com/doci/15648/control-1920x1080-ray-tracing-nvidia-dlss-2.0-quality-mode-performance_575px.png)

nVidia tried to [improve DLSS](https://www.anandtech.com/show/15648/nvidia-intros-dlss-20-adds-motion-vectors) and in fact they did. DLSS 2.0 is still about using machine learning to intelligently upscale a game to a higher resolution, however such a process is limited which means a native resolution should be preferred (if the hardware is powerful enough).

**Other things to mention**

The game/application developer still has to implement it themselves, NVIDIA can't make it happen at the driver level (yet).

