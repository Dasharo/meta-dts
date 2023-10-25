# Changelog

All notable changes to the DTS project will be documented in this file.

## v1.2.13 - 2023-11-x

* Added dasharo_ectool for updating EC
* Added
  [bg-suite](https://github.com/9elements/converged-security-suite/tree/main/cmd/bg-suite)

## v1.2.12 - 2023-11-03

* Fixed updating boards without Vboot slot B

## v1.2.11 - 2023-10-31

* Bumped supported firmware versions of NovaCustom to 1.5.1/1.7.1

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

* Added Dasharo zero-touch initial deployment on MSI PRO Z790-A for
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
* Improved versions comparision so update from any `rc` or `dev` version of
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
* `ec_transition` script now supports NV4XMB,ME,MZ laptops and automaticaly
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
  [firmware transition](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-ec-transition) for
  NS50 70MU and NS70 laptops.
* First public release: https://github.com/Dasharo/meta-dts.

## v1.0.0 2022-08-09

* Initial release v1.0.0.
* Auto-login functionality.
* User menu.
* [Dasharo HCL
  Report](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-hcl-report) -
  the ability to automatically dump device information and send it to 3mdeb
  servers.
* Possibility to manually [update the Dasharo
  firmware](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-firmware-update).
* [Bootable via
  iPXE](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#bootable-over-network).
* [Bootable via
  USB](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#bootable-usb-stick).
