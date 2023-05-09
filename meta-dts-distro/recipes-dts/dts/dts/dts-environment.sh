#!/usr/bin/env bash

BOARD_VENDOR="$(dmidecode -s system-manufacturer)"
SYSTEM_MODEL="$(dmidecode -s system-product-name)"
BOARD_MODEL="$(dmidecode -s baseboard-product-name)"

BIOS_VENDOR="$(dmidecode -s bios-vendor)"
BIOS_VERSION="$(dmidecode -s bios-version)"
DASHARO_VERSION="$(echo $BIOS_VERSION | cut -d ' ' -f 3 | tr -d 'v')"

# path to log files
ERR_LOG_FILE="/var/local/dts-err.log"
FLASHROM_LOG_FILE="/var/local/flashrom.log"

# variables defining Dasharo specific entires in DMI tables, used to check if
# Dasharo FW is already installed
DASHARO_VENDOR="3mdeb"
DASHARO_NAME="Dasharo"

CMD_POWEROFF="/sbin/poweroff"
CMD_REBOOT="/sbin/reboot"
