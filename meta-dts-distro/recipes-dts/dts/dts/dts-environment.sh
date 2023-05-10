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
CMD_SHELL="/bin/bash"
CMD_DASHARO_HCL_REPORT="/usr/sbin/dasharo-hcl-report"
CMD_NCMENU="/usr/sbin/novacustom_menu"
CMD_DASHARO_DEPLOY="/usr/sbin/dasharo-deploy"
CMD_CLOUD_LIST="/usr/sbin/cloud_list"
CMD_EC_TRANSITION="/usr/sbin/ec_transition"

# Dasharo Supporters Entrance variables
SE_credential_file="/etc/cloud-pass"
Cloud_base_url="https://cloud.3mdeb.com/index.php/s/"
# base values
BASE_CLOUDSEND_LOGS_URL="39d4biH4SkXD8Zm"
BASE_CLOUDSEND_PASSWORD="1{\[\k6G"
# base values
export CLOUDSEND_LOGS_URL="$BASE_CLOUDSEND_LOGS_URL"
export CLOUDSEND_PASSWORD="$BASE_CLOUDSEND_PASSWORD"


OS_VERSION_FILE="/etc/os-release"
