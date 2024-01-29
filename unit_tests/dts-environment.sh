#!/usr/bin/env bash

# Text Reset
COLOR_OFF='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'

# intentionally commented, to give as input
#BOARD_VENDOR="Notebook"
#SYSTEM_MODEL="NV4xPZ"
#BOARD_MODEL="NV4xPZ"

#BOARD_VENDOR="Micro-Star International Co., Ltd."
#SYSTEM_MODEL="MS-7D25"
#BOARD_MODEL="PRO Z690-A WIFI DDR4(MS-7D25)"

BIOS_VENDOR="3mdeb"
#BIOS_VERSION="Dasharo (coreboot+UEFI) v1.7.2" # intentionally commented, to give as input
DASHARO_VERSION="$(echo $BIOS_VERSION | cut -d ' ' -f 3 | tr -d 'v')"
DASHARO_FLAVOR="$(echo $BIOS_VERSION | cut -d ' ' -f 1,2)"

# path to temporary files, created while deploying or updating Dasharo firmware
BIOS_UPDATE_FILE="/tmp/biosupdate.rom"
EC_UPDATE_FILE="/tmp/ecupdate.rom"
BIOS_HASH_FILE="/tmp/bioshash.sha256"
EC_HASH_FILE="/tmp/echash.sha256"
BIOS_SIGN_FILE="/tmp/biossignature.sig"
EC_SIGN_FILE="/tmp/ecsignature.sig"
BIOS_UPDATE_CONFIG_FILE="/tmp/biosupdate_config"
RESIGNED_BIOS_UPDATE_FILE="/tmp/biosupdate_resigned.rom"
SYSTEM_UUID_FILE="/tmp/system_uuid.txt"
SERIAL_NUMBER_FILE="/tmp/serial_number.txt"

# default value for flash chip related information
FLASH_CHIP_SELECT=""
FLASH_CHIP_SIZE=""

# dasharo-deploy backup cmd related variables, do we still use and need this as
# backup is placed in HCL?
ROOT_DIR="/"
FW_BACKUP_NAME="fw_backup"
FW_BACKUP_DIR="${ROOT_DIR}${FW_BACKUP_NAME}"
FW_BACKUP_TAR="${FW_BACKUP_DIR}.tar.gz"
FW_BACKUP_TAR="$(echo "$FW_BACKUP_TAR" | sed 's/\ /_/g')"

# path to system files
ERR_LOG_FILE="/tmp/dts-err.log"
FLASHROM_LOG_FILE="/tmp/flashrom.log"
FLASH_INFO_FILE="/tmp/flash_info"
OS_VERSION_FILE="os-release"
KEYS_DIR="devkeys"

# path to system commands
CMD_POWEROFF="echo poweroff"
CMD_REBOOT="echo reboot"
CMD_SHELL="/bin/bash"
CMD_DASHARO_HCL_REPORT="$PWD/../meta-dts-distro/recipes-dts/dts/dasharo-hcl-report/dasharo-hcl-report"
CMD_NCMENU="novacustom_menu"
CMD_DASHARO_DEPLOY="$PWD/../meta-dts-distro/recipes-dts/dts/dasharo-deploy/dasharo-deploy"
CMD_CLOUD_LIST="$PWD/../meta-dts-distro/recipes-dts/dts/dts/cloud_list"
CMD_EC_TRANSITION="$PWD/../meta-dts-distro/recipes-dts/dts/dts/ec_transition"

# default values for flashrom programmer
PROGRAMMER_BIOS="internal"
PROGRAMMER_EC="ite_ec"

# variables defining Dasharo specific entries in DMI tables, used to check if
# Dasharo FW is already installed
DASHARO_VENDOR="3mdeb"
DASHARO_NAME="Dasharo"

# most the time one flash chipset will be detected, for other cases (like for
# ASUS KGPE-D16) we will test the following list in check_flash_chip function
FLASH_CHIP_LIST="W25Q64BV/W25Q64CV/W25Q64FV W25Q64JV-.Q W25Q128.V..M"

# Dasharo Supporters Entrance variables
SE_credential_file="$PWD/cloud-pass"
FW_STORE_URL="${FW_STORE_URL_DEV:-https://3mdeb.com/open-source-firmware/Dasharo}"
FW_STORE_URL_DES="https://cloud.3mdeb.com/public.php/webdav"
CLOUD_REQUEST="X-Requested-With: XMLHttpRequest"

## base values
BASE_CLOUDSEND_LOGS_URL="39d4biH4SkXD8Zm"
BASE_CLOUDSEND_PASSWORD="1{\[\k6G"

FLASHROM="flashrom_cmd"
DASHARO_ECTOOL="dasharo_ectool_cmd"

flashrom_cmd() {
    local _params="$*"

    grep -q "flash-name" <<< "$_params" && echo "vendor="Macronix" name="MX25L25635F/MX25L25645G"" && return 0
    grep -q "flash-size" <<< "$_params" && echo "$((32*1024*1024))" && return 0

    return 0
}

dasharo_ectool_cmd() {
    local _params="$*"

    return 0
}
