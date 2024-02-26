# DTS scripts unit tests

This directory contains stub scripts for testing DTS update and deploy logic
in complex scenarios.

## Prerequisities

The unit tests run on host without any isolation or framework for testing.
Thus the tests require the same tools and utilities to be present as on DTS:

* dasharo_ectool,
* cbfstool,
* futility,
* iotools,
* etc.

## Test switching to heads and back with updates

### NovaCustom

```bash
cd unit_tests
export BOARD_VENDOR="Notebook" SYSTEM_MODEL="NV4xPZ" BOARD_MODEL="NV4xPZ"
```

1. Dasharo v1.7.2 on NV4x_PZ eligible for updates to heads with heads DES and
   regular update:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" TEST_DES=y && ./dts-boot
    ```

2. Dasharo v1.7.2 on NV4x_PZ eligible for updates to heads without DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" TEST_DES=n && ./dts-boot
    ```

3. Dasharo v1.6.0 on NV4x_PZ not eligible for updates to heads with heads DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.6.0" TEST_DES=y && ./dts-boot
    ```

4. Dasharo v1.6.0 on NV4x_PZ not eligible for updates to heads without heads
   DES (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.6.0" TEST_DES=n && ./dts-boot
    ```

5. Dasharo heads v0.9.0 on NV4x_PZ eligible for updates to heads with heads
   DES and switch back (heads updates):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=y && ./dts-boot
    ```

6. Dasharo heads v0.9.0 on NV4x_PZ without DES switch back, no heads updates:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=n && ./dts-boot
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
cd unit_tests
export BOARD_VENDOR="Micro-Star International Co., Ltd." SYSTEM_MODEL="MS-7D25" BOARD_MODEL="PRO Z690-A WIFI DDR4(MS-7D25)"
```

1. Dasharo v1.1.1 on MS-7D25 eligible for updates to heads with heads DES and
   regular update:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.1" TEST_DES=y && ./dts-boot
    ```

2. Dasharo v1.1.1 on MS-7D25 eligible for updates to heads without DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.1" TEST_DES=n && ./dts-boot
    ```

3. Dasharo v1.1.2 on MS-7D25 eligible for updates to heads with heads DES
   (regular update only through regular DES):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.2" TEST_DES=y && ./dts-boot
    ```

4. Dasharo v1.1.2 on MS-7D25 not eligible for updates to heads without heads
   DES (regular update only through regular DES):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.1.2" TEST_DES=n && ./dts-boot
    ```

5. Dasharo heads v0.9.0 on MS-7D25 eligible for updates to heads with heads
   DES and switch back (regular update and switch-back):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=y && ./dts-boot
    ```

6. Dasharo heads v0.9.0 on MS-7D25 without DES switch back, no heads updates
   (regular update and switch-back):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=n && ./dts-boot
    ```

### MSI MS-7E06

```bash
cd unit_tests
export BOARD_VENDOR="Micro-Star International Co., Ltd." SYSTEM_MODEL="MS-7E06" BOARD_MODEL="PRO Z790-P WIFI (MS-7E06)"
```

1. Dasharo heads v0.9.0 on MS-7E06 eligible for updates to heads with heads
   DES and switch back (regular update and switch-back only through regular
   DES, no community release):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=y && ./dts-boot
    ```

2. Dasharo heads v0.9.0 on MS-7E06 without DES switch back, no heads updates
   (regular update and switch-back only through regular DES, no community
   release):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=n && ./dts-boot
    ```
