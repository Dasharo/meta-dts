# Changelog

All notable changes to the DTS Community Edition project will be documented in
this file.

## v1.1.0 - 2022-10-30

* Added [Dasharo zero-touch initial
  deployment](https://docs.dasharo.com/dasharo-tools-suite/documentation.md#dasharo-zero-touch-initial-deployment)
  for couple of supported platform
* Added multiple HCL report improvements, e.g. dump information about TPM, ME
* Refactored Dasharo Tools Suite [documentation](https://docs.dasharo.com/dasharo-tools-suite/overview.md)
* Added possibility to rollback using firmware dumped in HCL report
* Added documentation about [building Dasharo Tools Suite
  image](./documentation.md#building)
* Added Github Actions to automate new version building
* Added new tools: cbfstool, cbmem, futil, intelmetool (all from [Dasharo
  coreboot fork](https://github.com/Dasharo/coreboot/tree/coreboot-utils)),
  [binwalk](https://github.com/ReFirmLabs/binwalk),
  [uefi-firmware-parser](github.com/theopolis/uefi-firmware-parser),
  [mei-amt-check](github.com/mjg59/mei-amt-check)
* Updated flashrom to version
  [dasharo-v1.2.2](https://github.com/Dasharo/flashrom/tree/dasharo-v1.2.2)
* Deploying iPXE boot artifacts on
  [boot.dasharo.com](https://boot.dasharo.com/dts/)
* Sharing build cache on [cache.dasharo.com](https://cache.dasharo.com/yocto/dts/)

## v1.0.2 - 2022-10-12

* Added new vendor specific menu entry which is displayed only on supported
  platforms, for now NovaCustom menu was added for NV4x and NS50 70MU laptops
* DTS version is now printed in the main menu
* `ec_transition` script now supports NV4XMB,ME,MZ laptops and automaticaly
  download firmware used for transition both for NV4x and NS5x laptopts,
  [firmware transition](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-ec-transition)
  documentation is updated
* Add kernel configuration to silence terminal logs by default (change loglevel
  to 1)
* Enable GOOGLE_MEMCONSOLE_COREBOOT kernel configuration to ease getting
  firmware logs

## v1.0.1 - 2022-09-02

* Added system76_ectool to enable Embedded Controller [firmware
  updating](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-ec-update)
* Added ec_transition script which helps with full Dasharo/Embedded Controller
  [firmware transition](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-ec-transition) for
  NS50 70MU and NS70 laptops
* First public release: https://github.com/Dasharo/meta-dts

## v1.0.0 2022-07-28

* Initial release v1.0.0
* Auto-login functionality
* User menu
* [Dasharo HCL
  Report](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-hcl-report) -
  the ability to automatically dump device information and send it to 3mdeb
  servers
* Possibility to manually [update the Dasharo
  firmware](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#dasharo-firmware-update)
* [Bootable via
  iPXE](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#bootable-over-network)
* [Bootable via
  USB](https://docs.dasharo.com/common-coreboot-docs/dasharo_tools_suite/#bootable-usb-stick)
