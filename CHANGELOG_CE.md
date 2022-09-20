# Changelog

All notable changes to the DTS Community Edition project will be documented in
this file.

## v1.0.2 - 2022-09-20

* Added new vendor specific menu entry with NovaCustom menu
* `ec_transition` script now supports NV4XMB,ME,MZ laptops and automaticaly
  download firmware used for transition both for NV4x and NS5x laptopts,
  [firmware transition](TBD)
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
* First public release: https://github.com/Dasharo/meta-dts-ce

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
