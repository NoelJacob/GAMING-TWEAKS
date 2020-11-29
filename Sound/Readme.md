* [Do I need an internal sound card?](#do-i-need-an-internal-sound-card)
    * [The OHM problem](#the-ohm-problem)
    * [CPU problems](#cpu-problems)
    * [DAC & Drivers](#dac--drivers)
  * [Competitive fps and the "footstep" problematic](#competitive-fps-and-the-footstep-problematic)
* [Conclusion](#conclusion)
* [Realtek specific](#realtek-specific)
  * [Windows 10 specific Realtek settings](#windows-10-specific-realtek-settings)
  * [Microphone](#microphone)
  * [Common Tips](#common-tips)
  * [In-Game Tips](#in-game-tips)
  * [EqualizerAPO Tutorials](#equalizerapo-tutorials)
* [Modded sound drivers from DanielK, PAX & Co.](#modded-sound-drivers-from-danielk-pax--co)

## Do I need an internal sound card?

This question depends on multiple factors:

* Are you [audiophile](https://en.wikipedia.org/wiki/Audiophile)?
* Do you use "professional" headsets or speaker equipment? (_see explanation "The OHM problem" below_)
* How old are you? A well-known fact is that the older you get the ["less you hear"](https://www.hear-it.org/younger-and-older-people-respond-differently-sound) and your tolerance (_overall_) for loud noise [decreases with age](https://www.eurekalert.org/pub_releases/1998-11/OU-TFLN-191198.php). It's a [myth that older people have automatically ear "problems"](https://www.fastcompany.com/3064873/the-reason-why-old-people-have-bad-hearing-has-nothing-to-do-with-their-ears).



#### The OHM problem

Motherboards generally do not have enough power for complex speaker outputs, for example: - [Dolby Atmos](https://www.dolby.com/us/en/brands/dolby-atmos.html). Additionally, high-end headphones are typically rated at ~600 ohms, which is much more power than a motherboard audio IC can supply; therefore, an AMP/DAC would be required. With that being said, for headphones the ideal situation would be using an external AMP. For speakers the ideal situation is to run HDMI from your GPU into an AVR and then plug your speakers into the AVR.



#### CPU problems

Integrated audio solutions very often exclude a SPU which means your CPU is doing the entire work. The same goes for "audio effects", for example: - [Nahimic](https://www.msi.com/page/nahimic) (_each vendor names his effect different, MSI calls it "Nahimic"_), if you enable "a lot" or even one sound effect you automatically put more "pressure" on your CPU unless the sound chip includes an "acceleration" for this within the SPU.


#### DAC & Drivers

If you think a sound card would improve your experience, you're mostly always better off purchasing a DAC because (_overall_) it has a better value to performance and is more flexible in terms of performance. Another benefit is that a DAC does not need any drivers and there are no "PCIE issues". Overall a DAC can deliver the same benefit but without running into _possible_ driver problems.


### Competitive fps and the "footstep" problematic

Some say this is placebo effect, while others swear there is a benefit in using sound effects to "enhance" enemy footstep sound in e.g. CS:GO. From my experience this is a _matter of taste_, however if you want to enhance something you could use [Equalizer APO](https://sourceforge.net/projects/equalizerapo/), which can (_in real-time_) without much CPU pressure change the microphone, speakers/headset and correct sound frequencies.


## Conclusion

3.5 mm "gaming headsets" and other cheaper speakers aren't going to benefit you much with an internal or aftermarket sound card. A DAC has more "benefits" and is overall easier to handle. It's more flexible because there are limited driver and software problems.


You **typically do not need a sound card** unless:
* You have a dated CPU which can't handle the "extra pressure" for the sound processing sequence. The argument is generally weak these days, and because CPU's are so fast plus we have multiple cores this should not be a big argument anymore. Gamers generally always have "multi-core" CPU's.
* Sound effects are "cool" on paper but they can put extra pressure on your CPU, however modern games are typically designed to sound balanced (out-of-the-box) because game developers spend lots of time "optimizing" the sound for a maximum sound experience. Some older games do have "bad sounds" but even then, the community often provide "sound enhancement mods" to fix it, so there is no "pro argument" to use sound effects.

* Do not use speakers or headphones which "require" 600 Ohm; however, you can still can use the hardware with the onboard sound but it will sound worse: - ‘worse’ in context means noticeably lower volume with muddier bass.
* If you have speakers and want encoded audio like Dolby Atmos 5.1.4 or 7.1.4 then you should use an AVR. The problem here is that the independence and Ohm(s) are not "high" enough to handle this directly via an internal sound card to sound "powerful".


## Realtek specific

**Warning**: Sound effects will slightly increase the [DPC latency](https://superuser.com/questions/1206472/dpc-latency-issue-caused-by-realtek-controller-driver), which in turn could cause other problems like audio and video desynchronization or slow network speed. Sound enhancements could also have an adverse effect; it may sound better with your music, but could harm your audio positioning in games.


### Windows 10 specific Realtek settings

* In Windows 10 under "Speaker Configuration" select the number of speakers that you actually have. For a "5.1" audio system select "5.1" Speaker. For a "2.1" audio system select "Stereo". Selecting more channels than the number of speakers you have connected won’t enable you to hear more sounds or hear the footsteps and positioning of enemies better in games.
* Set the default playback format to "24Bit", "44100 Hz" this is generally good for most media (games, movies, music), while video DVDs use "48 kHz". Increasing the actual "Sample Rate" without having a source that’s sampled at a higher rate won’t improve the overall sound quality - in fact - it will degrade quality instead. Having the bit-depth set to 24bit will slightly improve audio quality. [You can find detailed information on audio bit-depth here](http://wiki.jriver.com/index.php/Audio_Bitdepth)
* If your Realtek Audio solution has a dedicated headphone amplifier, set the soundcards output impedance/gain (Ω = ohm) to a value close to the headphones input impedance. Do not set the impedance much higher as it may damage the headphones by outputting too much power.
* In case you like to emulate 8 channels surround on 2 channel headphones or speakers you need to right-click on Windows Volume tray icon-> Spatial Sounds-> select “Windows Sonic for Headphones”. Optionally, you can also try "Dolby Access", "DTS Sound Unbound" or "Dolby Atmos for Headphones" options. Once enabled it will automatically (_in the background_) change playback audio bit depth to 16bit with a sample rate of 44100 Hz.  When disabled Windows 10 will set the playback audio bit depth to 24bit and sample rate to 48000 Hz (_this is by design_).
* Optional: Set each individual application’s volume to ~80-90% in order to avoid "fluctuating volume" issue. Issue regarding setting volume to 100%. However, on newer Windows 10 builds (1809+) with the newer Realtek drivers this is not needed anymore.


### Microphone

* Set the microphone and/or ‘Line In’ default format to "24bit", "44100 Hz". The 44.1 kHz (44100 Hz) sample rate is the one used by most media (games, movies, music), while video DVDs use 48 kHz. Having the bit-depth set to 24 bit will slightly improve the recording audio quality, most USB mics and 3.5 mm mics (_unless it’s a professional device_) still using 44.1 kHz and there is no "benefit" nor "enhancement" setting it to 48.0 kHz (this also applies to recoding software like OBS Studio).
* If you’re using speakers and want to reduce the speaker output from being picked up by the microphone then enable Acoustic Echo Cancellation option under “Microphone Effects”.


### Common Tips

* Always select 2/2.1 speakers for your headphones if you want to utilize the full dynamic range, unless you have a real (not virtual) 7.1 headset. If set incorrectly you may experience sound disorientation, FPS especially benefit from a proper setup.
* Since the Windows April Update (Build 1803) you don’t need any external audio routing software in order to send the audio through a specific device or channel. This is [explained in detail over here](https://www.groovypost.com/howto/new-sound-settings-windows-10-1803-april-update/).
* Old Realtek drivers (up to Win 10 Redstone 2) were packaged in 200+ MB files, this has changed and improved since Windows RS 3 which means the Universal Audio Drivers (UAD) now come in smaller packages which weigh 20-40 MB max, depending which audio effects your OEM supports and can additionally install like ASIO, DSP, Creative or Windows Effects. However, normal non-OEM packages (the ones which are offered by Windows Update or Update Catalogue) usually exclude them (for no reason). So, you can 'tweak' your latency via ASIO and 'pimp' your effects by installing them additionally. I upload them separately under `Realtek ASIO, effects etc` so you can drop them into the installation folder or right click on the .inf and 'Install' it in order to unlock it.
* Universal Audio driver (UAD) and High Definition Drivers (HDA) drivers, including the latest UWP apps are available [here](https://github.com/alanfox2000/realtek-universal-audio-driver).
* Enable the audio output/playback to 24bit in media applications like VLC, MPC-BE/HC etc., this will slightly improve audio quality if the output material has a depth of 24bit (_which is the default today_).


### In-Game Tips

Set the sound quality to `Medium` or `High` (if there is such an option) depending on the importance of the sound quality for that particular game. This setting affects CPU usage. If you have a slow CPU you should select ‘Medium’, if you have a fast CPU you should select ‘High’. Setting the option to ‘High’ on a dated CPU may cause too much strain on your CPU and in turn can affect the FPS of that particular game.


### EqualizerAPO Tutorials
* [EqualizerAPO + ReaPlugs VSTs (Mic processing without virtual cables)](https://www.youtube.com/watch?v=J3fBx2ftaBs)
* [Fixing Microphone Reverb with Equalizer APO](https://www.youtube.com/watch?v=eySlFVYGk8E)



## Modded sound drivers from DanielK, PAX & Co.

In some situations a modded sound driver or all-in-one packages can has its benefits, e.g. when the original driver causes problems or does not include features like DolbyAtmos. If you need such features or want to test those tweaked driver/packages, then there are two great resources (_see links below_).

* [Daniel_K](https://danielkawakami.blogspot.com/) is a well-known sound card driver modder mainly for Realtek/Creative/Asus cards. Since the end of 2017 he did not updated his homepage nor driver packages.
* [PAX](https://www.hardwareheaven.com/community/forums/pax-drivers.174/) is a still active and known for his Creaitve/Asus sound packages/driver mods and tweaks. Some of his packages/mods are based in Daniel_K's work.
* [The Ultimate Realtek HD Audio Driver Mod for Windows 10](https://www.techpowerup.com/forums/threads/the-ultimate-realtek-hd-audio-driver-mod-for-windows-10.232921/page-112) is a thread on TechPowerUP around modding Realtek specific drivers to get Dolby, DTS, DTS:X 2,0 working. The thread provides All-in-One (AiO) packages, which you cn install on Windows 10 to get more sound effects and features. The member [Shibajee Roy](https://github.com/shibajee?tab=repositories) extracted everything from the AIO's an created repositories for each individual brand and sound effect, which makes the _Realtek modding_ overall easier.
