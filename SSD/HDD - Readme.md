* [What is SMR?](#what-is-smr)
  * [What is the issue?](#what-is-the-issue)
  * [Reports & Background](#reports--background)
  * [Affected Hardware](#affected-hardware)
  * [Official Statements](#official-statements)
  * [Response from the Media](#response-from-the-media)
  * [How to check if I'm affected or not](#how-to-check-if-im-affected-or-not)
  * [What to do?](#what-to-do)

## What is SMR?
[Shingled Magnetic Recording](https://en.wikipedia.org/wiki/Shingled_magnetic_recording) (SMR) basically spoken is a recording technique for HDDs, it overlaps tracks. This enhances the data layers per magnetic disc.

I do not like to go into deeper details, overall it's "slow(er)" than [Convential Magnetic Recording](https://en.wikipedia.org/wiki/Shingled_magnetic_recording) (CMR).

* SMR - Shingled Magnetic Recording
* PMR - Perpendicular Magnetic Recording
* CMR - Conventional Magnetic Record
* TDMR - Two Dimensional Magnetic Recording
* LMR - Longitudinal Magnetic Recording
* HAMR - Heat Assisted Magnetic Recording

### What is the issue?
Some vendors "cheating" which means they use SMR without any label/warning/information instead of CMR. There are differences between revisions and of course performance.

Can benchmarks detect/reveal it? [NO](https://blocksandfiles.com/2020/04/15/shingled-drives-have-non-shingled-zones-for-caching-writes/)!

[RAID problems](https://www.smartmontools.org/ticket/1313).

### Reports & Background
* https://community.synology.com/enu/forum/1/post/127228
* https://zfsonlinux.topicbox.com/groups/zfs-discuss/T759a10612888a9d9/beware-of-smr-drives-in-pmr-clothing
* https://blocksandfiles.com/2020/04/15/shingled-drives-have-non-shingled-zones-for-caching-writes/
* https://www.reddit.com/r/DataHoarder/comments/g1di7w/wd_admits_red_nas_drives_2tb6tb_are_smr/
* https://unix.stackexchange.com/questions/504245/s-m-a-r-t-shows-high-load-cycle-count-why-and-how-to-prevent-the-number-from/504246#504246

### Affected Hardware
* WD-Model WD60EFAX
* Toshiba DT02 (3,5"): SMR -> 4 TB and 6 TB
* Toshiba P300: SMR -> 4 TB and 6 TB
* Toshiba MQ04 (2,5"): SMR -> 1 TB and 2 TB
* Toshiba L200: SMR -> 1 TB and 2 TB
* Seagate Barracuda 2TB ST2000DM008 (3,5", 7.200 U/min, SATA)
* Seagate Barracuda 4TB ST4000DM004 (3,5", 5.400 U/min, SATA)
* Seagate Barracuda 8TB ST8000DM004 (3,5", 5.400 U/min, SATA)
* Seagate Desktop HDD 5TB ST5000DM000 (3,5", 5.900 U/min, SATA)
* [Synology](https://www.synology.com/en-global/compatibility?search_by=category&category=hdds_no_ssd_trim&filter_brand=Seagate&filter_type=3.5%22%20SATA%20HDD&p=2)
* [Seagate IronWolf ST4000VN008](https://www.synology.com/en-us/knowledgebase/DSM/tutorial/Storage/PMR_SMR_hard_disk_drives) (PMR)

### Official Statements
> All our WD Red drives are designed meet or exceed the performance requirements and specifications for common small business/home NAS workloads. We work closely with major NAS providers to ensure WD Red HDDs (and SSDs) at all capacities have broad compatibility with host systems. Currently, Western Digital’s WD Red 2TB-6TB drives are device-managed SMR (DMSMR). WD Red 8TB-14TB are CMR-based.

- Western Digital, [PDF](http://products.wdc.com/library/SpecSheet/ENG/2879-800002.pdf)

-------------------------------------------------

> WD and Seagate are _both_ shipping drive-managed SMR (DM-SMR) drives which don't report themselves as SMR when questioned via conventional means. What's worse, they're shipping DM-SMR drives as "RAID" and "NAS" drives This is causing MAJOR problems - such as the latest iteration of WD REDs (WDx0EFAX replacing WDx0EFRX) being unable to be used for rebuilding RAID[56] or ZFS RAIDZ sets: They rebuild for a while (1-2 hours), then throw errors and get kicked out of the set.

-------------------------------------------------

- [smartmontools.org](https://www.smartmontools.org/)

Due to the characteristics of SMR, this SMR drive might have longer response time than a PMR drive. It is highly recommended not to mix SMR and PMR drives in one RAID type.

- Synology-Support zur WD60EFAX

-------------------------------------------------

> We optimize our drive designs and specifications to be consistent with the positioning and intended workload for each drive. Our product descriptions and documentation provide the information needed to choose the right drive for the right application.

Seagate


### Response from the Media
* [Blocks & Files](https://blocksandfiles.com/2020/04/14/wd-red-nas-drives-shingled-magnetic-recording/)
* [Tom's Hardware](https://www.tomshardware.com/news/wd-fesses-up-some-red-hdds-use-slow-smr-tech)
* [Smarttools.org](https://www.smartmontools.org/ticket/1313)
* [WD Support](https://support-en.wd.com/app/answers/detail/a_id/25185)
* [OpenZFS European Conference 2015](https://youtu.be/a2lnMxMUxyc?t=807)
* [Beware of SMR drives in CMR clothing](https://www.smartmontools.org/ticket/1313)


### How to check if I'm affected or not
- Download/Install (or use portable) [CrystalDiskInfo](https://crystalmark.info/en/software/crystaldiskinfo/)
- Open and run the program, if it shows that [TRIM is supported](https://support-en.wd.com/app/answers/detail/a_id/25185), it means SMR is currently in use.

**Another Indicator** seems the cache (_WD example_)
* EFRX -> 64MB Cache -> CMR
* EFAX -> 256MB Cache -> SMR

**Via Linux command**
```bash
# hdparm -I /dev/sda | grep TRIM
*    Data Set Management TRIM supported (limit 8 blocks)
```

### What to do?
Report and avoid hardware with SMR due to performance reasons. Vendors should and MUST label it to make it clear and visible if SMR is in use or not.
