# meta-dts

## Prerequisites

* Linux PC (tested on `Ubuntu 20.04/22.04 LTS` and `NixOS 22.11`)
* [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) installed
* [kas-container 3.0.2](https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container)
  script downloaded and available in [PATH](https://en.wikipedia.org/wiki/PATH_(variable))

```bash
wget -O ~/bin/kas-container https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container
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

## Build

From `yocto` directory run:

```shell
SHELL=/bin/bash kas-container build meta-dts/kas.yml
```

- Image build takes time, so be patient and after build's finish you should see
something similar to (the exact tasks numbers may differ):

```shell
Initialising tasks: 100% |###########################################################################################| Time: 0:00:01
Sstate summary: Wanted 2 Found 0 Missed 2 Current 931 (0% match, 99% complete)
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 2532 tasks of which 2524 didn't need to be rerun and all succeeded.
```

### Build image with UEFI Secure Boot support

From `yocto` directory run:

```shell
SHELL=/bin/bash kas-container build meta-dts/kas-uefi-sb.yml
```

- Image build takes time, so be patient and after build's finish you should see
something similar to (the exact tasks numbers may differ):

```shell
Initialising tasks: 100% |###########################################################################################| Time: 0:00:04
Checking sstate mirror object availability: 100% |###################################################################| Time: 0:00:03
Sstate summary: Wanted 892 Local 672 Mirrors 212 Missed 8 Current 1560 (99% match, 99% complete)
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 5860 tasks of which 5841 didn't need to be rerun and all succeeded.
```

Image created with `kas-uefi-sb.yml` configuration file enable integration of
UEFI Secure Boot into DTS using
[meta-secure-core](https://github.com/jiazhang0/meta-secure-core/). Building the
image allows to prepare a PoC version with
[uses sample keys](https://github.com/jiazhang0/meta-secure-core/tree/master/meta-efi-secure-boot#sample-keys)
which by no mean should used in production. For user keys the script
[create-user-key-store.sh](https://github.com/jiazhang0/meta-secure-core/blob/master/meta-signing-key/scripts/create-user-key-store.sh)
can be used but it was not tested yet. Quick start with instructions on how to
use image are described in
[meta-efi-secure-boot](https://github.com/jiazhang0/meta-secure-core/tree/master/meta-efi-secure-boot#quick-start-for-the-first-boot).

## Flash

- Find out your device name:

```shell
fdisk -l
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
sudo umount /dev/sdx*
```

```shell
cd build/tmp/deploy/images/genericx86-64
```

Here the file `dts-base-image-genericx86-64.wic.gz` should be available which
is the image of DTS. To flash image you can use the same command as showed in
[running
section](https://docs.dasharo.com/dasharo-tools-suite/documentation/#launching-dts_1),
just change the file name.
- Boot the platform

## Supported Hardware

Dasharo Tools Suite was prepared to run on x86 platforms, but we can confirm
that it boots on the following platforms:

* ASUS KGPE-D16
* Dell OptiPlex 7010/9010
* MSI PRO Z690-A DDR4 ([test
  report](https://docs.google.com/spreadsheets/d/16wokQYhtS7XA1DQC3Om7FY-IImG6SZisGK7NnzyRGVY/edit#gid=0&range=A75))
* NovaCustom NV4x ([test
  report](https://docs.google.com/spreadsheets/d/1LOXY9HCu-fMitkYwX08iLsQdSNenzyU0LnMdVbZB5Do/edit#gid=536764189&range=A161))
* NovaCustom NS5x/7x ([test
  report](https://docs.google.com/spreadsheets/d/1LOXY9HCu-fMitkYwX08iLsQdSNenzyU0LnMdVbZB5Do/edit#gid=38447675&range=A174))
* Protectli FW6/VP46xx

## Reporting issues

Thank you for using Dasharo Tools Suite Community Edition. If you have
encountered any problems with this version, or would like to provide feedback
for us - please open an issue.
