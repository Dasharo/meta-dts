# meta-dts

## Prerequisites

* Linux PC (tested on `Ubuntu 20.04 LTS`)

* [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) installed

* [kas-container 2.6.3](https://raw.githubusercontent.com/siemens/kas/2.6.3/kas-container)
  script downloaded and available in [PATH](https://en.wikipedia.org/wiki/PATH_(variable))

```bash
wget -O ~/bin/kas-container https://raw.githubusercontent.com/siemens/kas/2.6.3/kas-container
```

```bash
chmod +x ~/bin/kas-container
```

* `meta-dts` repository cloned

```bash
mkdir yocto && cd yocto
```

```bash
git clone https://github.com/Dasharo/meta-dts.git
```

or if you have SSH access:

```bash
git clone git@github.com:Dasharo/meta-dts.git
```

* [bmaptool](https://source.tizen.org/documentation/reference/bmaptool) installed

```bash
sudo apt install bmap-tools
```

> You can also use `bmap-tools`
> [from github](https://github.com/intel/bmap-tools) if it is not available in
> your distro.

## Build

From `yocto` directory run:

```shell
$ SHELL=/bin/bash kas-container build meta-dts/kas.yml
```

- Image build takes time, so be patient and after build's finish you should see
something similar to (the exact tasks numbers may differ):

```shell
Initialising tasks: 100% |###########################################################################################| Time: 0:00:01
Sstate summary: Wanted 2 Found 0 Missed 2 Current 931 (0% match, 99% complete)
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 2532 tasks of which 2524 didn't need to be rerun and all succeeded.
```

## Flash

- Find out your device name:

```shell
$ fdisk -l
```

output:

```shell
(...)
Device     Boot  Start    End Sectors  Size Id Type
/dev/sdx1  *      8192 131433  123242 60,2M  c W95 FAT32 (LBA)
/dev/sdx2       139264 186667   47404 23,2M 83 Linux
```

in this case the device name is `/dev/sdx` **but be aware, in next steps
replace `/dev/sdx` with right device name on your platform or else you can
damage your system!.**

- From where you ran image build type:

```shell
$ cd build/tmp/deploy/images/genericx86-64
$ sudo umount /dev/sdx*
$ sudo bmaptool copy --nobmap dts-base-image-ce-genericx86-64.wic.gz /dev/sdx
```

and you should see output similar to this (the exact size number may differ):

```shell
bmaptool: info: no bmap given, copy entire image to '/dev/sdx'
/
bmaptool: info: synchronizing '/dev/sdx'
bmaptool: info: copying time: 33.2s, copying speed 31.9 MiB/sec
```

- Boot the platform

## Supported Hardware

Below are list of platforms on which the operation of Dasharo Tools Suite has
been confirmed.

* **CE**
  - NovaCustom NV4x
  - Dell OptiPlex 7010/9010
  - NS50 70MU

## Reporting issues

Thank you for using Dasharo Tools Suite Community Edition. If you have
encountered any problems with this version, or would like to provide feedback
for us - please open an issue.
