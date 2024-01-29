# DTS scripts unit tests

This directory contains stub scripts for testing DTS update and deploy logic
in complex scenarios.

There are some unsolved dependencies like dasharo_ectool, cbfstool, futility.

## Test switching to heads and back with updates

```bash
export BOARD_VENDOR="Notebook" SYSTEM_MODEL="NV4xPZ" BOARD_MODEL="NV4xPZ"
```

1. Dasharo v1.7.2 on NV4x_PZ eligible for updates to heads with heads DES and
   regular update:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" TEST_DES=y && source dts-boot
    ```

2. Dasharo v1.7.2 on NV4x_PZ eligible for updates to heads without DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" TEST_DES=n && source dts-boot
    ```

3. Dasharo v1.6.0 on NV4x_PZ not eligible for updates to heads with heads DES
   (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.6.0" TEST_DES=y && source dts-boot
    ```

4. Dasharo v1.6.0 on NV4x_PZ not eligible for updates to heads without heads
   DES (regular update only):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+UEFI) v1.6.0" TEST_DES=n && source dts-boot
    ```

5. Dasharo heads v0.9.0 on NV4x_PZ eligible for updates to heads with heads
   DES and switch back (heads updates):

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=y && source dts-boot
    ```

6. Dasharo heads v0.9.0 on NV4x_PZ without DES switch back, no heads updates:

    ```bash
    export BIOS_VERSION="Dasharo (coreboot+heads) v0.9.0" TEST_DES=n && source dts-boot
    ```

Another case is to edit `dts-functions.sh` and set `DASHARO_REL_VER` to
`v1.7.3` to detect possible regular firmware updates and `HEADS_REL_VER_DES`
to `v0.9.1` to detect possible heads firmware updates and repeat all test
cases. The URLs for non-existing versions may fail. Also it may be worth trying
with MSI board as mocked input and MSI Z690-A v1.1.1 and v1.1.2 versions.

The test binaries for credentials in `dts-boot` are placed in
[/projects/projects/2022/novacustom/dts_test](https://cloud.3mdeb.com/index.php/f/659609)
on 3mdeb cloud.