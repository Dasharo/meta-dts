# Changelog

All notable changes to the DTS project will be documented in this file.

## v1.2.21 - 2024-03-29

* Added Dasharo zero-touch initial deployment on PCEngines APU2 platforms for
  [DES](https://docs.dasharo.com/ways-you-can-help-us/#become-a-dasharo-entry-subscription-subscriber)
  users.
* Addeded hw-probe utility which is used at the end of HCL report.
* Blocked possibility to run Dasharo deployment on Z690 platform with 13th gen
  CPU; issue
  [440](https://github.com/Dasharo/dasharo-issues/issues/440)
* Updated 3mdeb-secpack to revision f52771d2d001c55b164fae397d060d6e5af9c733

## v1.2.20 - 2024-03-19

* Enabled switch from Dasharo (coreboot+UEFI) to Dasharo (coreboot+heads) on
  MSI Z690-A and MSI Z790-P. Switch back is not possible, please see information
  from release notes for
  [MSI Z690-A](https://github.com/Dasharo/docs/tree/master/docs/variants/msi_z690/heads.md#transition-from-dasharo-heads-back-to-uefi)
  and
  [MSI Z790-P](https://github.com/Dasharo/docs/tree/master/docs/variants/msi_z790/heads.md#transition-from-dasharo-heads-back-to-uefi).
* Added Dasharo (coreboot+heads) v0.9.0 for MSI Z690-A and MSI Z790-P.
* Fixed initial deployment for NovaCustom NV4x TGL; issue
  [699](https://github.com/Dasharo/dasharo-issues/issues/699).
* Fixed HCL report generation when started from shell; issue
  [736](https://github.com/Dasharo/dasharo-issues/issues/736).
* Changed DTS boot partition type to EFI; issue
  [692](https://github.com/Dasharo/dasharo-issues/issues/692).
* Removed ISO image from release artifacts until reported usability issues are
  fixed; issue
  [288](https://github.com/Dasharo/dasharo-issues/issues/288#issuecomment-1995053693).
* Updated flashrom to revision f5a48aa6c67bd30603062bb4265419fd49f83870
* Updated 3mdeb-secpack to revision c844b4ba536cde4813c8e4088bf069ac90ef9c27

## v1.2.19 - 2024-02-28

* Enabled switch between Dasharo (coreboot+UEFI) and Dasharo (coreboot+heads) on
  NovaCustom NV4X ADL.
* Added Dasharo (coreboot+heads) v0.9.0 for NovaCustom NV4X ADL.
* Added missing TPM2 related packages needed to work with TPM2.
* Enabled IOMMU support in used Linux kernel.
* Fixed feature to [run commands from iPXE
  shell](https://docs.dasharo.com/dasharo-tools-suite/documentation/#run-commands-from-ipxe-shell)
* Updated 3mdeb-secpack to revision c48af6eb2698f255c19a48a602b0e474137b07ef

## v1.2.18 - 2024-01-22

* Bumped supported firmware versions of MSI Z690-A to v1.1.3 and MSI Z790-P to
  v0.9.1.
* Improved logic for determining flashrom update parameters.

## v1.2.17 - 2024-01-17

* Bumped supported firmware versions of NovaCustom NS5X TGL to v1.5.2.
* Fixed DTS build with UEFI Secure Boot enabled.
* Fixed minor typos in scripts.
* Updated 3mdeb-secpack to revision 2225894887fc81a1c72b067edbe348b5f3f02a05

## v1.2.16 - 2024-01-11

* Bumped supported firmware versions of NovaCustom NV4X TGL to v1.5.2.
* Improved release process of DTS images in release-candidate versions.

## v1.2.15 - 2024-01-11

* Fixed GPG signature verification on MSI and Dell OptiPlex platforms.
* Updated ACM checksums used when deploying Dasharo firmware on Dell OptiPlex.
* Enhanced the user experience (UX) when running deployment or update
  procedures. Fewer logs are displayed on the terminal, while all of them are
  still stored under the `/var/local` path.
* Improved the CI/CD pipelines.

## v1.2.14 - 2024-01-03

* Added 3mdeb Master Key and 3mdeb Dasharo Master Key from
  [3mdeb-secpack](https://github.com/3mdeb/3mdeb-secpack/) with trust set to
  ultimate.
* Added wic.bmap files to release artifacts; issue
  [70](https://github.com/Dasharo/meta-dts/issues/70).

## v1.2.13 - 2023-12-22

* Added [dasharo_ectool](https://github.com/Dasharo/ec) for updating EC.
* Added [bg-suite](https://github.com/9elements/converged-security-suite/tree/main/cmd/bg-suite).
* Added [Dasharo configuration utility](https://github.com/Dasharo/dcu) that is
  a tool designed to configure Dasharo firmware binary images. It includes task
  such as customizing the boot logo, and setting unique UUIDs or Serial Numbers
  in SMBIOS tables.
* Added support for exFAT and NTFS file systems.
* Added ACPI BGRT support in kernel.
* Added signature verification of Dasharo firmware binaries.
* Added possibility to run updates from [local server](./README.md#testing-dasharo-firmware-updates-from-local-sources).
* Added check if charger is connected before update on laptops.
* Added bootsplash migration to preserve logo while updating Dasharo firmware.
* Fixed network failure errors and added waiting for network to be up before
  calling update; issue
  [588](https://github.com/Dasharo/dasharo-issues/issues/588).

## v1.2.12 - 2023-11-03

* Fixed updating boards without Vboot slot B.

## v1.2.11 - 2023-10-31

* Bumped supported firmware versions of NovaCustom to 1.5.1/1.7.1.

## v1.2.10 - 2023-10-27

* Added
  [coreboot_customizer](https://docs.dasharo.com/guides/image-customization/#usage)
  which allow to change logo displayed on boot.
* Added SMMSTORE migration for NovaCustom laptops, so the Dasharo Setup settings
  are preserved after firmware update.
* Added CI/CD pipeline to generate signatures.

## v1.2.9 - 2023-09-29

* Added [Firmware Update
  Mode](https://docs.dasharo.com/guides/firmware-update/#firmware-update-mode)
  integration, which speed up the process of Dasharo firmware update.
* Added efivars support and efivar utility.
* Fixed problem with EC firmware links and hashes.
* Improved logging of DTS menu options.

## v1.2.8 - 2023-09-06

* Check for SMM protection before trying to flash.

## v1.2.7 - 2023-09-05

* Added Dasharo zero-touch initial deployment on MSI PRO Z790-P for
  [DES](https://docs.dasharo.com/ways-you-can-help-us/#become-a-dasharo-entry-subscription-subscriber)
  users.
* Added Dasharo firmware update to version v1.1.2 on MSI PRO Z690-A for
  [DES](https://docs.dasharo.com/ways-you-can-help-us/#become-a-dasharo-entry-subscription-subscriber)
  users.
* Updated coreboot-utils to support Raptor Lake.
* Added couple UX improvements for DTS scripts, specially in the context of
  [DES](https://docs.dasharo.com/ways-you-can-help-us/#become-a-dasharo-entry-subscription-subscriber)
  users.
* Correctly fixed downloading Dell BIOS Update packages.

## v1.2.6 - 2023-08-31

* Added [txt-suite](https://github.com/9elements/converged-security-suite/releases/download/v2.6.0/txt-suite).

## v1.2.5 - 2023-08-07

* Fixed downloading Dell BIOS Update packages.

## v1.2.4 - 2023-07-12

* Added [me_cleaner](https://github.com/corna/me_cleaner).

## v1.2.3 - 2023-06-16

* Enabled devmem applet for buxybox.

## v1.2.2 - 2023-06-16

* Updated coreboot-utils to support Alder Lake.

## v1.2.1 - 2023-06-16

* Updated coreboot-utils to support Jasper Lake.

## v1.2.0 - 2023-05-10

* Added Dasharo [firmware
  update](https://docs.dasharo.com/dasharo-tools-suite/documentation/#firmware-update)
  option for [supported
  platforms](https://docs.dasharo.com/dasharo-tools-suite/documentation/#supported-hardware).
* Disabled SSH server by default and added menu option to start/stop SSH server.
* Improved versions comparison so update from any `rc` or `dev` version of
  Dasharo firmware is possible.
* Improved UX a little by saving flashrom logs to file.
* Fixed CI workflows.
* Added IXGBE driver as a module.

## v1.1.1 - 2023-02-20

* Fixed Dasharo zero-touch initial deployment on MSI PRO Z690-A, added DDR5
  target with dedicated firmware.
* Blocked Dasharo zero-touch initial deployment on platforms where Dasharo
  firmware was detected.
* Added couple UX improvements for Dasharo zero-touch initial deployment:
    - added platform verification step (show detected device information),
    - added firmware verification step (show hash of using binary),
    - added progress bar on first instructions,
    - used reboot as default behavior after successful flashing.
* Added improvements for HCL report.
* Added DTS ISO format image, and documentation about
  [VentoyOS](./documentation.md#run-dts-using-ventoyos) usage.
* Improved `README` of the `meta-dts` repository.
* Added service to run shell [commands from
  iPXE](./documentation.md#run-commands-from-ipxe-shell).
* Added instructions for building PoC image with [enabled UEFI Secure
  Boot](./documentation.md#build-image-with-uefi-secure-boot-support) support.

## v1.1.0 - 2022-11-02

* Added [Dasharo zero-touch initial
  deployment](https://docs.dasharo.com/dasharo-tools-suite/documentation.md#dasharo-zero-touch-initial-deployment)
  for couple of supported platform.
* Added multiple HCL report improvements, e.g. dump information about TPM, ME.
* Refactored Dasharo Tools Suite [documentation](https://docs.dasharo.com/dasharo-tools-suite/overview.md).
* Added possibility to rollback using firmware dumped in HCL report.
* Added documentation about [building Dasharo Tools Suite
  image](./documentation.md#building).
* Added Github Actions to automate new version building.
* Added new tools: cbfstool, cbmem, futil, intelmetool (all from [Dasharo
  coreboot fork](https://github.com/Dasharo/coreboot/tree/coreboot-utils)),
  [binwalk](https://github.com/ReFirmLabs/binwalk),
  [uefi-firmware-parser](github.com/theopolis/uefi-firmware-parser),
  [mei-amt-check](github.com/mjg59/mei-amt-check).
* Updated flashrom to version
  [dasharo-v1.2.2](https://github.com/Dasharo/flashrom/tree/dasharo-v1.2.2).
* Deploying iPXE boot artifacts on
  [boot.dasharo.com](https://boot.dasharo.com/dts/).
* Sharing build cache on [cache.dasharo.com](https://cache.dasharo.com/yocto/dts/).

## v1.0.2 - 2022-10-19

* Added new vendor specific menu entry which is displayed only on supported
  platforms, for now NovaCustom menu was added for NV4x and NS50 70MU laptops.
* DTS version is now printed in the main menu.
* `ec_transition` script now supports NV4XMB,ME,MZ laptops and automatically
  download firmware used for transition both for NV4x and NS5x laptopts,
  [firmware transition](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-ec-transition)
  documentation is updated.
* Add kernel configuration to silence terminal logs by default (change loglevel
  to 1).
* Enable GOOGLE_MEMCONSOLE_COREBOOT kernel configuration to ease getting
  firmware logs.

## v1.0.1 - 2022-09-02

* Added system76_ectool to enable Embedded Controller [firmware
  updating](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-ec-update).
* Added ec_transition script which helps with full Dasharo/Embedded Controller
  [firmware transition](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-ec-transition)
  for NS50 70MU and NS70 laptops.
* First public release: <https://github.com/Dasharo/meta-dts>.

## v1.0.0 2022-08-09

* Initial release v1.0.0.
* Auto-login functionality.
* User menu.
* [Dasharo HCL
  Report](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-hcl-report)
  \- the ability to automatically dump device information and send it to 3mdeb
  servers.
* Possibility to manually [update the Dasharo
  firmware](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-firmware-update).
* [Bootable via
  iPXE](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#bootable-over-network).
* [Bootable via
  USB](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#bootable-usb-stick).
