* [Disable "Inbound Layer 7" on your router](#disable-inbound-layer-7-on-your-router)
* [Reducing the Network latency to eliminate microstuttering in games](#reducing-the-network-latency-to-eliminate-microstuttering-in-games)
  * [Verdict](#verdict)

### Disable Windows 10 driver updates delivered through Windows Update

See ["How to temporarily prevent a driver update from reinstalling in Windows 10"](https://support.microsoft.com/en-us/help/3073930/how-to-temporarily-prevent-a-driver-update-from-reinstalling-in-window). Another alternative is using [WuMGr](https://github.com/DavidXanatos/wumgr) which is basically a front-end for Windows crippled Windows Update interface, it basically spoken can take control over the Windows Updater mechanism by e.g. settings registry/gpo settings and also includes some more options to handle updates.


### Wi-Fi Scanning can cause 'latency' spikes

Some [Intel Wireless adapters](https://www.intel.com/content/www/us/en/support/articles/000005546/network-and-i-o/wireless-networking.html) and [Atheros adapters](https://superuser.com/questions/881880/turn-off-wi-fi-scanning-on-windows-8) are known to cause some small [latency spikes](https://blog.mojonetworks.com/background-scanning-is-dead) (_original link dead!_). On older operating systems [WLAN Optimizer](http://www.martin-majowski.de/) tool was a workaround to resolve this issue, since [Windows 10](https://answers.microsoft.com/en-us/windows/forum/windows_10-networking/is-there-any-way-to-stop-windows-10-from-scanning/3870b3d1-0f07-4875-8779-bb5c11fce0a8) you can do this directly under Windows [without any tools](https://pastebin.com/WAdTPBpC).

Some newer drivers also including an option in the network adapter option to configure/enable/disable the Wi-Fi scan interval.

##### Turn off Wi-Fi background scans for Atheros adapters

* Go to the `Control Panel`.
* Choose `Networks and Sharing` and `Change Adapter Settings`.
* Right-click on your `Wi-Fi adapter icon` and select `Properties`.
* Click `Configure` which is located under `Connect Using`.
* Go to the `Advanced` tab.
* Set `Background Scan` to `Disabled`.
* Set `Foreground Scan` to `Disabled`.

##### Turn off Wi-Fi background scans for Atheros adapters

* Type `ncpa.cpl` into the Windows search box which opens the Network Connectivity Manager
* Right-click on the `Wi-Fi adapter icon` and select `Properties`.
* Click the `Configure` button on the driver property page.
* On the `Advanced tab`, scroll down the `Property` list and set `Roaming Aggressiveness` to `Lowest`.
* Click `OK` to apply it to all opened settings.


##### Turn of Wireless Autoconfig globally

Some Windows 10 Builds (not all, some need to change the registry toggle because it's locked service task) allowing you to disabling the `Wireless Autoconfig` [service](https://windowsreport.com/make-windows-stop-searching-wireless-networks/), this prevents Windows to search for new Wi-Fi networks in general (_useful if you're only connected via ethernet_).



### Intel Adapter 'Recommended' Network Adapter Settings

Network adapter settings are usually accessed through it's driver properties. From "Device Manager", or by right-clicking the adapter connection, choosing properties and then configure.

Keep in mind that some drivers might have different settings/options! After talking with NordVPN I figured out with them that some settings might directly have a negative effect on Down-/Upload speed. Ensure you test each settings one by one. In this case try to disable all "offloading" params.


#### Optimized for quick response and low latency (Gaming):

* Disable Interrupt Moderation Rate (if not possible decrease the size)
* Disable Offload TCP Segmentation
* Increase Transmit Descriptors
* Increase Receive Descriptors
* Increase RSS Queues


#### Optimized for throughput (e.g. Servers):

* Enable Jumbo Frames
* Increase Transmit Descriptors
* Increase Receive Descriptors


#### For low CPU utilization:

* Maximize Interrupt Moderation Rate
* Keep Receive Descriptors at default
* Avoid setting large Receive Descriptors
* Decrease RSS Queues
* Decrease the Max number of RSS CPUs in Hyper-V environments


#### Optional disable/change the following in your Network Adapter

* `Disable` Adaptive Inter-Frame Spacing
* `Disable` Flow Control
* `Disable` Interrupt Moderation
* Set Interrupt Moderation Rate to `OFF` (not needed if you disable Interrupt Moderation)
* Set Enable PME to `Disabled`
* `Disable` all “Offload” features
* `Disable` Packet Priority & VLAN
* `Disable` Jumbo Packet
* Set Receive Side Scaling (RSS) - `ENABLED`
* RSS Balancing Mode - `NUMAScaling`
* **Don't touch Speed & Duplex, leave it on Auto Negotiation**

#### tweaks via CMD/PowerShell

```
netsh interface teredo set state disabled
netsh interface 6to4 set state disabled
netsh winsock reset
netsh interface isatap set state disable
netsh int tcp set global timestamps=disabled
netsh int tcp set heuristics disabled
netsh int tcp set global autotuninglevel=disable
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set supplemental Internet congestionprovider=CTCP
netsh int tcp set global chimney=disabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global rss=enabled
netsh int tcp set global rsc=disabled
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
PowerShell Disable-NetAdapterChecksumOffload -Name "*"
PowerShell Disable-NetAdapterLso -Name "*"
PowerShell Disable-NetAdapterRsc -Name "*"
PowerShell Disable-NetAdapterIPsecOffload -Name "*"
PowerShell Disable-NetAdapterPowerManagement -Name "*"
PowerShell Disable-NetAdapterQos -Name "*"
```

#### Enable or disable QoS?

It depends on how you set up your QoS/WMM. QoS is useful in scenarios where your network experiences peak or near-peak loads on a routine basis. If the network is not under significant load, QoS rules will not be applied, the same goes if your router is not configured to use QoS or the firmware doesn't includes it.

For example, if you live alone, don't play online games, don't use VOIP, don't use video streaming services (Netflix/Amazon/Hulu/Twitch.tv & YouTube), or don't use P2P file sharing - QoS is not going to be all that beneficial to you.

* Check if you're ISP offers a QoS package to residential connections (most do)
* Check your Router QoS settings
* Check your OS QoS options

In general **I recommend to leave it enabled**. If there some problems check your configuration instead, I did some benchmarks and I never found any impact (because my router isn't configured to use it). It's right that Windows reserves some bandwidth but that doesn't matter because your router might ignore the flags.


### Optional network tweaks
___


## Disable "Inbound Layer 7" on your router
Layer 7 filtering or shaping is identifying traffic at layer 7 (Application Layer) of the OSI model. Instead of shaping/filtering based on the port and source/destination, you are identifying a stream based on its contents. This is also sometimes called deep packet inspection since it works by looking into the contents of the packets not just the headers. If you're concerned about performance: IPP2P and especially L7 are slower than simple IP, MAC or port matches. L7 can't cope well with encrypted P2P traffic in background while gaming.

* Enable SYN cookies
* Disable IPv6 tunnel adapter & interfaces
* Disable all ISATAP, 6to4 and Teredo Tunneling interfaces
* Ensure Windows Defender Core Isolation stays disabled (default) it can causes 'lags' with several older games
* Disable the Timeline function, it eats HDD space in order to collect your history or if you use it, ensure e.g. CCleaner cleans it -> bigger file means longer loading times.

```bash
netsh interface teredo set state disable
netsh interface 6to4 set state disable disable
netsh interface isatap set state disable
REG ADD "HKLM\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters" /v "EnableICSIPv6" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 255 /f
```


Keep in mind that every modern Router firmware has an option to block or at least filter Teredo traffic, same like NetBios which means you don't need to 'disable' everything blindly because nothing can pass the router anyway!



## Reducing the Network latency to eliminate microstuttering in games

 The [Multimedia Class Scheduler](https://docs.microsoft.com/en-us/windows/win32/procthread/multimedia-class-scheduler-service?redirectedfrom=MSDN) Service has built-in network throttling which can degrade performance of online games. That's the theory.

This [network tweak](https://www.speedguide.net/articles/gaming-tweaks-5812) aims to reduce the network latency, however this tweak is [controversial](http://forum.sudden-strike-alliance.fr/all-problem-with-lag-on-windows-7-and-10-t2807.html) because modern network cards/adapters already handlining it very well. The values are depending on `AvSetMmMaxThreadCharacteristics()` & `AvSetMmThreadCharacteristics()` and what Windows 10 version you use, most mentioned entries are already set by default to a good value.

Whenever you load a thread for this e.g. while gaming it must use these [two API's](https://www.installsetupconfig.com/win32programming/windowsthreadsprocessapis7_4.html) otherwise nothing will happen. So this depends how the game implemented the netcode. More information regarding this topic is avbl. over [here](http://msdn2.microsoft.com/en-us/library/ms681973.aspx), [here](http://msdn2.microsoft.com/en-us/library/ms681974.aspx) and [here](https://docs.microsoft.com/en-us/windows/win32/procthread/multimedia-class-scheduler-service?redirectedfrom=MSDN).

The task priority ranges from 1, which represents "low" to 8, which represent "high". However, the scheduling category overrides this, so that if scheduling category is automatically to "High", then the priority value is automatically set to 2 (unless gaming mode was activated and the game supports it).

```bash
Windows Registry Editor Version 5.00

; I do not recommended using this!
; Starting with Windows 1909 this is not anymore needed.
; https://github.com/NoelJacob/GamingTweaks/issues/5

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile]
"NetworkThrottlingIndex"=dword:ffffffff
"SystemResponsiveness"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"Scheduling Category"="High"
"SFIO Priority"="High"
"Background Only"="False"
"Priority"=dword:00000001
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000001
"Affinity"=dword:00000000
```

[Multimedia streaming](http://msdn2.microsoft.com/en-us/library/ms684247.aspx) and some other games that uses [Multimedia Class Scheduler service (MMCSS)](https://docs.microsoft.com/en-us/windows/desktop/procthread/multimedia-class-scheduler-service) can only utilize up to 80% of your CPU. MMCSS ensures prioritized access to CPU resources, without denying CPU resources to lower-priority background applications.

### Verdict
If a [game](https://www.reddit.com/r/GlobalOffensive/comments/646v5q/fps_boost_with_windows_10_update/) supports explicitly Game Mode, then this old "tweak" is redundant (after Windows 10 1809+ due to Game Mode changes) (_assuming you use + enabled Game Mode_). If the netnode differs or was optimized then it's also obsolete since the Game internally handles it different. So overall spoken it's depending on the Game, one example is the old Call of Duty, this game can get a benefit from using the mentioned tweak but that's the only game I found (so far).
