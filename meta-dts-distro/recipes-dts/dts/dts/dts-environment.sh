#!/usr/bin/env bash

# Text Reset
COLOR_OFF='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'

BOARD_VENDOR="$(dmidecode -s system-manufacturer)"
SYSTEM_MODEL="$(dmidecode -s system-product-name)"
BOARD_MODEL="$(dmidecode -s baseboard-product-name)"

BIOS_VENDOR="$(dmidecode -s bios-vendor)"
BIOS_VERSION="$(dmidecode -s bios-version)"
DASHARO_VERSION="$(echo $BIOS_VERSION | cut -d ' ' -f 3 | tr -d 'v')"

# TBD CMNT

BIOS_UPDATE_FILE="/tmp/biosupdate.rom"
EC_UPDATE_FILE="/tmp/ecupdate.rom"

FLASH_CHIP_SELECT=""
FLASH_CHIP_SIZE=""

CLOUD_REQUEST="X-Requested-With: XMLHttpRequest"

# path to system files
ERR_LOG_FILE="/var/local/dts-err.log"
FLASHROM_LOG_FILE="/var/local/flashrom.log"
FLASH_INFO_FILE="/tmp/flash_info"
OS_VERSION_FILE="/etc/os-release"

# path to system commands
CMD_POWEROFF="/sbin/poweroff"
CMD_REBOOT="/sbin/reboot"
CMD_SHELL="/bin/bash"
CMD_DASHARO_HCL_REPORT="/usr/sbin/dasharo-hcl-report"
CMD_NCMENU="/usr/sbin/novacustom_menu"
CMD_DASHARO_DEPLOY="/usr/sbin/dasharo-deploy"
CMD_CLOUD_LIST="/usr/sbin/cloud_list"
CMD_EC_TRANSITION="/usr/sbin/ec_transition"

# variables defining Dasharo specific entires in DMI tables, used to check if
# Dasharo FW is already installed
DASHARO_VENDOR="3mdeb"
DASHARO_NAME="Dasharo"

# most the time one flash chipset will be detected, for other cases (like for
# ASUS KGPE-D16) we will test the following list in check_flash_chip function
FLASH_CHIP_LIST="W25Q64BV/W25Q64CV/W25Q64FV W25Q64JV-.Q W25Q128.V..M"

# Dasharo Supporters Entrance variables
SE_credential_file="/etc/cloud-pass"
Cloud_base_url="https://cloud.3mdeb.com/index.php/s/"
FW_STORE_URL="https://3mdeb.com/open-source-firmware/Dasharo"
FW_STORE_URL_DES="https://cloud.3mdeb.com/public.php/webdav"

## base values
BASE_CLOUDSEND_LOGS_URL="39d4biH4SkXD8Zm"
BASE_CLOUDSEND_PASSWORD="1{\[\k6G"
