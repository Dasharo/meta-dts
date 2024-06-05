# DTS scripts unit tests

This directory contains stub scripts for testing DTS update and deploy logic
in complex scenarios.

## Prerequisites

Running test on the host may result in unpredictable results because of the
missing programs and different version of certain tools. It is advised to run
the DTS image in QEMU as a development environment. Running on host is
generally not supported and should be avoided.

## Running in QEMU

### Credentials setup

We need credentials for each test variant. You can use provided template and
fill it in accordingly.

```bash
cp des-credentials.sh.example des-credentials.sh
```

### Running automatically

Some scenarios are have been already migrated into [OSFV](TBD).

```bash
robot -L TRACE -v config:qemu -v rte_ip:127.0.0.1 -v snipeit:no dts/dts-tests.robot
```

### Running manually

1. Boot the latest DTS image in QEMU. Recommended steps:
  - start QEMU according to
    [OSFV documentation](https://github.com/Dasharo/open-source-firmware-validation/blob/develop/docs/qemu.md#booting)
    (use `os` switch, not `firmware`)
  - enable network boot and boot into DTS via iPXE
  - enable SSH server (option `8` in main menu)

1. Deploy updated scripts and tests into qemu

    ```bash
    PORT=5222 ./scripts/local-deploy.sh 127.0.0.1
    ```

1. Execute desired test as described in below section. E.g.:

    ```
    ssh -p 5222 root@127.0.0.1
    export BOARD_VENDOR="Notebook" SYSTEM_MODEL="NV4xPZ" BOARD_MODEL="NV4xPZ"
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" TEST_DES=y DES_TYPE="heads" && dts-boot
    ```

## Test cases

The general idea is that we override some variables, so DTS scripts consider
they are running on the given board. Then we select `Install` or `Update`
actions from DTS menu, and check if the flow is as expected in certain
scenario.

After each `dts-boot -> 5) Check and apply Dasharo firmware updates` scenario
exection, we can drop to DTS shell and continue with the next scenario.

### NovaCustom

```bash
export BOARD_VENDOR="Notebook" SYSTEM_MODEL="NV4xPZ" BOARD_MODEL="NV4xPZ"
```

1. Dasharo v1.7.2 on NV4x_PZ eligible for updates to heads with heads DES and
   regular update:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" TEST_DES=y DES_TYPE="heads" && dts-boot
    ```

Expected output:
- heads fw should be offered

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 1.7.2
Latest available Dasharo version: 1.7.2
Dasharo Heads firmware version is available and your subscription
gives you access to this firmware.

Would you like to switch to Dasharo heads firmware? (Y|n) y


Switching to Dasharo heads firmware v0.9.1

Are you sure you want to proceed with update? (Y|n) y

Downloading Dasharo firmware...Done

Please verify detected hardware!

Board vendor: Notebook
System model: NV4xPZ
Board model: NV4xPZ

Does it match your actual specification? (Y|n) y

Following firmware will be used to install Dasharo
Dasharo BIOS firmware:
  - link: https://cloud.3mdeb.com/public.php/webdav/novacustom_nv4x_adl/v0.9.1/novacustom_nv4x_adl_v0.9.1_heads.rom
  - hash: b64e92ebce59e0ee4aca8f134b41abb987703f329149c17730ac5861d8715b5e

You can learn more about this release on: https://docs.dasharo.com/

Do you want to update Dasharo firmware on your hardware? (Y|n) y

Checking Dasharo firmware checksum... Verified.
Checking Dasharo firmware signature... Verified.

Device does not have Dasharo EC firmware - cannot continue update! : (1)
```

2. Dasharo v1.7.2 on NV4x_PZ eligible for updates to heads without DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" TEST_DES=n && dts-boot
    ```

Expected output:
- no update should be offered

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 1.7.2
Latest available Dasharo version: 1.7.2
Dasharo heads firmware version is available. If you are interested,
please provide your subscription credentials in the main DTS menu
and select 'Update Dasharo firmware' again to check if you are eligible.
No update available for your machine
```

3. Dasharo v1.6.0 on NV4x_PZ not eligible for updates to heads with heads DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.6.0" TEST_DES=y DES_TYPE="heads" && dts-boot
    ```

Expected output:
- UEFI fw update should be offered (this is too old release to transition to
  heads directly, need to flash latest UEFI fw first)

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 1.6.0
Latest available Dasharo version: 1.7.2

Are you sure you want to proceed with update? (Y|n) y

Downloading Dasharo firmware...Done

Please verify detected hardware!

Board vendor: Notebook
System model: NV4xPZ
Board model: NV4xPZ

Does it match your actual specification? (Y|n) y

Following firmware will be used to install Dasharo
Dasharo BIOS firmware:
  - link: https://dl.3mdeb.com/open-source-firmware/Dasharo/novacustom_nv4x_adl/v1.7.2/novacustom_nv4x_adl_v1.7.2.rom
  - hash: 00b6338389cc5d020b641629971aac6d4047be6134c6e8d0228140edc42584f6

You can learn more about this release on: https://docs.dasharo.com/

Do you want to update Dasharo firmware on your hardware? (Y|n) y

Checking Dasharo firmware checksum... Verified.
Checking Dasharo firmware signature... Verified.

Device does not have Dasharo EC firmware - cannot continue update! : (1)
```

4. Dasharo v1.6.0 on NV4x_PZ not eligible for updates to heads without heads
   DES (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.6.0" TEST_DES=n && dts-boot
    ```

Expected output:
- UEFI fw update should be offered

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 1.6.0
Latest available Dasharo version: 1.7.2

Are you sure you want to proceed with update? (Y|n) y

Downloading Dasharo firmware...Done

Please verify detected hardware!

Board vendor: Notebook
System model: NV4xPZ
Board model: NV4xPZ

Does it match your actual specification? (Y|n) y

Following firmware will be used to install Dasharo
Dasharo BIOS firmware:
  - link: https://dl.3mdeb.com/open-source-firmware/Dasharo/novacustom_nv4x_adl/v1.7.2/novacustom_nv4x_adl_v1.7.2.rom
  - hash: 00b6338389cc5d020b641629971aac6d4047be6134c6e8d0228140edc42584f6

You can learn more about this release on: https://docs.dasharo.com/

Do you want to update Dasharo firmware on your hardware? (Y|n) y

Checking Dasharo firmware checksum... Verified.
Checking Dasharo firmware signature... Verified.

Device does not have Dasharo EC firmware - cannot continue update! : (1)
```

5. Dasharo heads v0.9.0 on NV4x_PZ eligible for updates to heads with heads
   DES and switch back (heads updates):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=y DES_TYPE="heads" && dts-boot
    ```

Expected output:
- migration to UEFI should be offered first
- if we say `n` to switch, heads update should be offered

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 0.9.0
Latest available Dasharo version: 0.9.1

If you are running heads firmware variant and want to update, say "n" here.
You will be asked for heads udpate confirmation in a moment.
Say "Y" only if you want to migrate from heads to UEFI firmware variant.
Would you like to switch back to the regular (UEFI) Dasharo firmware variant? (Y|n) y


Switching back to regular Dasharo firmware v1.7.2


Are you sure you want to proceed with update? (Y|n) y

Downloading Dasharo firmware...Done

Please verify detected hardware!

Board vendor: Notebook
System model: NV4xPZ
Board model: NV4xPZ

Does it match your actual specification? (Y|n) y

Following firmware will be used to install Dasharo
Dasharo BIOS firmware:
  - link: https://dl.3mdeb.com/open-source-firmware/Dasharo/novacustom_nv4x_adl/v1.7.2/novacustom_nv4x_adl_v1.7.2.rom
  - hash: 00b6338389cc5d020b641629971aac6d4047be6134c6e8d0228140edc42584f6

You can learn more about this release on: https://docs.dasharo.com/

Do you want to update Dasharo firmware on your hardware? (Y|n) y

Checking Dasharo firmware checksum... Verified.
Checking Dasharo firmware signature... Verified.

```

6. Dasharo heads v0.9.0 on NV4x_PZ without DES switch back, no heads updates:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=n && dts-boot
    ```

Expected output:
- migration to UEFI should be offered first
- if we say `n` to switch, no heads update should be offered

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 0.9.0
You are running heads firmware, but did not provide DES credentials.
There are updates available if you provide DES credentials in main DTS menu.

Latest available Dasharo version: 0.9.1


Would you like to switch back to the regular Dasharo firmware? (Y|n) y


Switching back to regular Dasharo firmware v1.7.2


Are you sure you want to proceed with update? (Y|n) y

Downloading Dasharo firmware...Done

Please verify detected hardware!

Board vendor: Notebook
System model: NV4xPZ
Board model: NV4xPZ

Does it match your actual specification? (Y|n) y

Following firmware will be used to install Dasharo
Dasharo BIOS firmware:
  - link: https://dl.3mdeb.com/open-source-firmware/Dasharo/novacustom_nv4x_adl/v1.7.2/novacustom_nv4x_adl_v1.7.2.rom
  - hash: 00b6338389cc5d020b641629971aac6d4047be6134c6e8d0228140edc42584f6

You can learn more about this release on: https://docs.dasharo.com/

Do you want to update Dasharo firmware on your hardware? (Y|n) y

Checking Dasharo firmware checksum... Verified.
Checking Dasharo firmware signature... Verified.
```

Another case is to edit `dts-functions.sh` and set `DASHARO_REL_VER` to
`v1.7.3` to detect possible regular firmware updates and `HEADS_REL_VER_DES`
to `v0.9.1` to detect possible heads firmware updates and repeat all test
cases. The URLs for non-existing versions may fail.

The NovaCustom test binaries for credentials in `dts-boot` are placed in
[/projects/projects/2022/novacustom/dts_test](https://cloud.3mdeb.com/index.php/f/659609)
on 3mdeb cloud. These are just public coreboot+UEFI v1.7.2 binaries.
Analogically with MSI, cloud directory is
[/projects/projects/2022/msi/dts_test](https://cloud.3mdeb.com/index.php/f/667474)
and binaries are simply Z690-A public coreboot+UEFI v1.1.1 binaries with
changed names for both Z690-A and Z790-P (resigned with appropriate keys).

### MSI MS-7D25

```bash
export BOARD_VENDOR="Micro-Star International Co., Ltd." SYSTEM_MODEL="MS-7D25" BOARD_MODEL="PRO Z690-A WIFI DDR4(MS-7D25)"
```

1. Dasharo v1.1.1 on MS-7D25 eligible for updates to heads with heads DES and
   regular update:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.1" TEST_DES=y DES_TYPE="heads" && dts-boot
    ```

2. Dasharo v1.1.1 on MS-7D25 eligible for updates to heads without DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.1" TEST_DES=n && dts-boot
    ```

3. Dasharo v1.1.2 on MS-7D25 eligible for updates to heads with heads DES
   (regular update only through regular DES):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.2" TEST_DES=y DES_TYPE="heads" && dts-boot
    ```

4. Dasharo v1.1.2 on MS-7D25 not eligible for updates to heads without heads
   DES (regular update only through regular DES):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.2" TEST_DES=n && dts-boot
    ```

5. Dasharo heads v0.9.0 on MS-7D25 eligible for updates to heads with heads
   DES and switch back (regular update and switch-back):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=y DES_TYPE="heads" && dts-boot
    ```

6. Dasharo heads v0.9.0 on MS-7D25 without DES switch back, no heads updates
   (regular update and switch-back):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=n && dts-boot
    ```

### MSI MS-7E06

```bash
export BOARD_VENDOR="Micro-Star International Co., Ltd." SYSTEM_MODEL="MS-7E06" BOARD_MODEL="PRO Z790-P WIFI (MS-7E06)"
```

1. Dasharo heads v0.9.0 on MS-7E06 eligible for updates to heads with heads
   DES and switch back (regular update and switch-back only through regular
   DES, no community release):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=y DES_TYPE=heads && dts-boot
    ```

Expected output:
- migration to UEFI should be offered first
- if we say `n` to switch, no heads (no more recent update available yet)

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 0.9.0
Latest available Dasharo version: 0.9.0

If you are running heads firmware variant and want to update, say "n" here.
You will be asked for heads udpate confirmation in a moment.
Say "Y" only if you want to migrate from heads to UEFI firmware variant.
Would you like to switch back to the regular (UEFI) Dasharo firmware variant? (Y|n) y


Switching back to regular Dasharo firmware v0.9.1


Are you sure you want to proceed with update? (Y|n) y

Downloading Dasharo firmware...Done

Please verify detected hardware!

Board vendor: Micro-Star International Co., Ltd.
System model: MS-7E06
Board model: PRO Z790-P WIFI (MS-7E06)

Does it match your actual specification? (Y|n) y

Following firmware will be used to install Dasharo
Dasharo BIOS firmware:
  - link: https://cloud.3mdeb.com/public.php/webdav/MS-7E06/v0.9.1/msi_ms7e06_v0.9.1_ddr5.rom
  - hash: 3b438422338cf4c13abdb25823a9b2a2ad6e82fabbe0d9ed41a16a6eae1f15ff

You can learn more about this release on: https://docs.dasharo.com/

Do you want to update Dasharo firmware on your hardware? (Y|n) y

Checking Dasharo firmware checksum... Verified.
Checking Dasharo firmware signature... Verified.

Backing up firmware configuration... Failed! Default settings will be used.
Failed! Default settings will be used.
Done.
Found file config at 0xa2b40, type raw, compressed 2480, size 2480
Checking flash layout.
Could not read the FMAP region
Updating Dasharo firmware...
This may take several minutes. Please be patient and do not power off your computer or touch the keyboard!
Failed to update Dasharo firmware : (1)
```


2. Dasharo heads v0.9.0 on MS-7E06 without DES switch back, no heads updates
   (regular update and switch-back only through regular DES, no community
   release):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=n && dts-boot
    ```

Expected output:
- should print info on DES availability in the shop
- migration to UEFI should be offered

```
Enter an option: 5

Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: vendor="ST" name="M95M02"
Flash size: 0M
Getting platform specific GPG key... Done
Checking for the latest Dasharo update available...
Current Dasharo version: 0.9.0
DES version available, if you are interested
please visit https://shop.3mdeb.com/product-category/dasharo-entry-subscription/

Latest available Dasharo version: 0.9.0


Would you like to switch back to the regular Dasharo firmware? (Y|n) n
```

### PC Engines

```bash
export BOARD_VENDOR="PC Engines" SYSTEM_MODEL="APU2" BOARD_MODEL="APU2"
```

1. Initial deployment from legacy firmware (no DES credentials)

    ```bash
    export BIOS_VERSION="v4.19.0.1" TEST_DES=n && dts-boot
    ```

Expected output:
- no DES - no deployment should be offered
- info on DES availailbity in the shop should be shown

```
Enter an option: 2

Waiting for network connection ...
Preparing ...
Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: Mock flashrom: Extra options = --flash-name 
/usr/sbin/dts-functions.sh: line 652: Mock flashrom: Extra options = --flash-size  / 1024 / 1024: syntax error in expression (error token is "flashrom: Extra options = --flash-size  / 1024 / 1024")
Backing up BIOS firmware and store it locally...
Remember that firmware is also backed up in HCL report.
Saving backup to: /fw_backup.tar.gz
tar: Removing leading `/' from member names
Successfully backed up firmware locally at: /fw_backup.tar.gz

Please, select Dasharo firmware version to install
  DES version available, if you are interested, please visit https://shop.3mdeb.com/product-category/dasharo-entry-subscription/
  b) Back to main menu

Enter an option: b
```

2. Initial deployment from legacy firmware (UEFI DES credentials)

    ```bash
    export BIOS_VERSION="v4.19.0.1" TEST_DES=y DES_TYPE="UEFI" && dts-boot
    ```

Expected output:
- UEFI deployment should be offered
- info on DES availailbity in the shop should not be shown

```
Enter an option: 2

Waiting for network connection ...
Preparing ...
Waiting for network connection ...
Checking if board is Dasharo compatible.
Gathering flash chip and chipset information...
Flash information: Mock flashrom: Extra options = --flash-name 
/usr/sbin/dts-functions.sh: line 652: Mock flashrom: Extra options = --flash-size  / 1024 / 1024: syntax error in expression (error token is "flashrom: Extra options = --flash-size  / 1024 / 1024")
Backing up BIOS firmware and store it locally...
Remember that firmware is also backed up in HCL report.
Saving backup to: /fw_backup.tar.gz
tar: Removing leading `/' from member names
Successfully backed up firmware locally at: /fw_backup.tar.gz

Please, select Dasharo firmware version to install
  d) DES version
  b) Back to main menu

Enter an option: d

Dasharo Entry Subscription version selected
Downloading Dasharo firmware...Done

Please verify detected hardware!

Board vendor: PC Engines
System model: APU2
Board model: APU2

Does it match your actual specification? (Y|n) y

Following firmware will be used to install Dasharo
Dasharo BIOS firmware:
  - link: https://cloud.3mdeb.com/public.php/webdav/pcengines_apu2/v0.9.0/pcengines_apu2_v0.9.0.rom
  - hash: 5943fcff46add5161f520d4c4e3612496aa07933951bbc77c58ec847f07c12b9

You can learn more about this release on: https://docs.dasharo.com/

Do you want to install Dasharo firmware on your hardware? (Y|n) y

Checking Dasharo firmware checksum... Verified.

Found file config at 0x1eae00, type raw, compressed 3848, size 12269
CONFIG_VBOOT=y
Installing Dasharo firmware...
Successfully installed Dasharo firmware
Syncing disks... Done.
The computer will reboot automatically in 5 seconds
```

3. Initial deployment from legacy firmware (seabios DES credentials)

    ```bash
    export BIOS_VERSION="v4.19.0.1" TEST_DES=y DTS_TYPE="seabios" && dts-boot
    ```

Expected output:
- Seabios deployment should be offered
- info on DES availailbity in the shop should not be shown

```
TBD
```

4. Initial deployment from legacy firmware (correct DES credentials)

    ```bash
    export BIOS_VERSION="v4.19.0.1" TEST_DES=n && dts-boot
    ```

Expected output:
- seabios deployment should be offered
- info on DES availailbity in the shop should not be shown

```
TBD
```
