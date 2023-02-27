#!/usr/bin/env bash

BOARD_VENDOR="$(dmidecode -s system-manufacturer)"
SYSTEM_MODEL="$(dmidecode -s system-product-name)"
BOARD_MODEL="$(dmidecode -s baseboard-product-name)"

BIOS_VENDOR="$(dmidecode -s bios-vendor)"
BIOS_VERSION="$(dmidecode -s bios-version)"

# variables defining Dasharo specific entires in DMI tables, used to check if
# Dasharo FW is already installed
DASHARO_VENDOR="3mdeb"
DASHARO_NAME="Dasharo"

CMD_POWEROFF="/sbin/poweroff"
CMD_REBOOT="/sbin/reboot"
CMD_SHELL="/bin/bash"
CMD_DASHARO_HCL_REPORT="/usr/sbin/dasharo-hcl-report"
CMD_NCMENU="/usr/sbin/novacustom_menu"
CMD_DASHARO_DEPLOY="/usr/sbin/dasharo-deploy"
CMD_CLOUD_LIST="/usr/sbin/cloud_list"
