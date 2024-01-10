#!/usr/bin/env bash

source /usr/sbin/dts-environment.sh

### Color functions
print_warning() {
  echo -e "$YELLOW""$1""$COLOR_OFF"
}

print_error() {
  echo -e "$RED""$1""$COLOR_OFF"
}

print_green() {
  echo -e "$GREEN""$1""$COLOR_OFF"
}

check_if_dasharo() {
  if [[ $BIOS_VENDOR == *$DASHARO_VENDOR* && $BIOS_VERSION == *$DASHARO_NAME* ]]; then
    return 0
  else
    return 1
  fi
}

check_if_ac() {
  local _ac_file="/sys/class/power_supply/AC/online"

  if [ ! -e "${_ac_file}" ]; then
    # We want to silently skip if AC file is not there. Most likely this is
    # not battery-powered device then.
    return 0
  fi

  while true; do
    ac_status=$(cat ${_ac_file})

    if [ "$ac_status" -eq 1 ]; then
      echo "AC adapter is connected. Continuing with firmware update."
      return
    else
      print_warning "Warning: AC adapter must be connected before performing firmware update."
      print_warning "Please connect the AC adapter and press 'C' to continue, or 'Q' to quit."

      read -n 1 -r input
      case $input in
       [Cc])
          echo "Checking AC status again..."
          ;;
        [Qq])
          echo "Quitting firmware update."
          return 1
          ;;
        *)
          echo "Invalid input. Press 'C' to continue, or 'Q' to quit."
          continue
          ;;
      esac
    fi
  done
}

### Error checks

# instead of error exit in dasharo-deploy exit we need to reboot the platform
# in cases where there would be some problem with updating the platform
fum_exit() {
    if [ "$FUM" == "fum" ]; then
      print_error "Update cannot be performed"
      print_warning "Starting bash session - please make sure you get logs from\r
      \r$ERR_LOG_FILE and $FLASHROM_LOG_FILE; then you can poweroff the platform"
      /bin/bash
    fi
}

error_exit() {
  _error_msg="$1"
  if [ -n "$_error_msg" ]; then
    # Avoid printing empty line if no message was passed
    print_error "$_error_msg"
  fi
  fum_exit
  exit 1
}

error_check() {
  _error_code=$?
  _error_msg="$1"
  [ "$_error_code" -ne 0 ] && error_exit "$_error_msg : ($_error_code)"
}

function error_file_check {
  if [ ! -f "$1" ]; then
    print_error "$2"
  fi
}

### Clevo-specific functions
# Method to access IT5570 IO Depth 2 registers
it5570_i2ec() {
  # TODO: Use /dev/port instead of iotools

  # Address high byte
  iotools io_write8 0x2e 0x2e
  iotools io_write8 0x2f 0x11
  iotools io_write8 0x2e 0x2f
  iotools io_write8 0x2f $(($2>>8 & 0xff))

  # Address low byte
  iotools io_write8 0x2e 0x2e
  iotools io_write8 0x2f 0x10
  iotools io_write8 0x2e 0x2f
  iotools io_write8 0x2f $(($2 & 0xff))

  # Data
  iotools io_write8 0x2e 0x2e
  iotools io_write8 0x2f 0x12
  iotools io_write8 0x2e 0x2f

  case $1 in
    "r")
      iotools io_read8 0x2f
      ;;
    "w")
      iotools io_write8 0x2f "$3"
      ;;
  esac
}

it5570_shutdown() {
  # shut down using EC external watchdog reset
  it5570_i2ec w 0x1f01 0x20
  it5570_i2ec w 0x1f07 0x01
}

check_network_connection() {
  echo 'Waiting for network connection ...'
  n="10"
  while : ; do
    ping -c 3 cloud.3mdeb.com > /dev/null 2>&1 && break
    n=$((n-1))
    if [ "${n}" == "0" ]; then
      echo 'No network connection to 3mdeb cloud, please recheck Ethernet connection'
      return 1
    fi
    sleep 1
  done
  return 0
}

## Supported boards configuration

board_config() {
  # We download firmwares via network. At this point, the network connection
  # must be up already.
  check_network_connection

  echo "Checking if board is Dasharo compatible."
  case "$BOARD_VENDOR" in
    "Notebook")
      case "$SYSTEM_MODEL" in
        "NV4XMB,ME,MZ")
          DASHARO_REL_NAME="novacustom_nv4x_tgl"
          DASHARO_REL_VER="1.5.1"
          BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}.rom"
          EC_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_ec_v${DASHARO_REL_VER}.rom"
          HAVE_EC="true"
          NEED_EC_RESET="true"
          COMPATIBLE_EC_FW_VERSION="2022-10-07_c662165"
          EC_HASH_LINK_COMM="$EC_LINK_COMM.sha256"
          BIOS_HASH_LINK_COMM="$BIOS_LINK_COMM.sha256"
          EC_SIGN_LINK_COMM="$EC_LINK_COMM.sha256.sig"
          BIOS_SIGN_LINK_COMM="$BIOS_LINK_COMM.sha256.sig"
          PLATFORM_SIGN_KEY="customer-keys/novacustom/novacustom-open-source-firmware-release-1.x-key.asc"
          NEED_SMBIOS_MIGRATION="false"
          NEED_SMMSTORE_MIGRATION="true"
          NEED_BOOTSPLASH_MIGRATION="false"
          NEED_BLOB_TRANSMISSION="false"
          PROGRAMMER_BIOS="internal"
          PROGRAMMER_EC="ite_ec"
          FLASHROM_ADD_OPT_DEPLOY="--ifd -i bios"
          if check_if_dasharo; then
          # if v1.4.0 or older, flash the whole bios region, as per:
          # TBD
            compare_versions $DASHARO_VERSION 1.5.0
            if [ $? -eq 1 ]; then
              # For Dasharo version lesser than 1.5.0
              NEED_BOOTSPLASH_MIGRATION="true"
              FLASHROM_ADD_OPT_UPDATE="--ifd -i bios"
            else
              # For Dasharo version greater or equal 1.5.0
              FLASHROM_ADD_OPT_UPDATE="--fmap -i RW_SECTION_A"
            fi
          fi
          ;;
        "NS50_70MU")
          DASHARO_REL_NAME="novacustom_ns5x_tgl"
          DASHARO_REL_VER="1.5.1"
          BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}.rom"
          EC_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_ec_v${DASHARO_REL_VER}.rom"
          HAVE_EC="true"
          NEED_EC_RESET="true"
          COMPATIBLE_EC_FW_VERSION="2022-08-31_cbff21b"
          EC_HASH_LINK_COMM="$EC_LINK_COMM.sha256"
          BIOS_HASH_LINK_COMM="$BIOS_LINK_COMM.sha256"
          EC_SIGN_LINK_COMM="$EC_LINK_COMM.sha256.sig"
          BIOS_SIGN_LINK_COMM="$BIOS_LINK_COMM.sha256.sig"
          PLATFORM_SIGN_KEY="customer-keys/novacustom/novacustom-open-source-firmware-release-1.x-key.asc"
          NEED_SMBIOS_MIGRATION="false"
          NEED_SMMSTORE_MIGRATION="true"
          NEED_BOOTSPLASH_MIGRATION="false"
          NEED_BLOB_TRANSMISSION="false"
          PROGRAMMER_BIOS="internal"
          PROGRAMMER_EC="ite_ec"
          FLASHROM_ADD_OPT_DEPLOY="--ifd -i bios"
          if check_if_dasharo; then
          # if v1.4.0 or older, flash the whole bios region, as per:
          # TBD
            compare_versions $DASHARO_VERSION 1.5.0
            if [ $? -eq 1 ]; then
              # For Dasharo version lesser than 1.5.0
              NEED_BOOTSPLASH_MIGRATION="true"
              FLASHROM_ADD_OPT_UPDATE="--ifd -i bios"
            else
              # For Dasharo version greater or equal 1.5.0
              FLASHROM_ADD_OPT_UPDATE="--fmap -i RW_SECTION_A"
            fi
          fi
          ;;
        "NS5x_NS7xPU")
          DASHARO_REL_NAME="novacustom_ns5x_adl"
          DASHARO_REL_VER="1.7.2"
          BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}.rom"
          EC_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_ec_v${DASHARO_REL_VER}.rom"
          HAVE_EC="true"
          NEED_EC_RESET="true"
          COMPATIBLE_EC_FW_VERSION="2022-08-31_cbff21b"
          EC_HASH_LINK_COMM="$EC_LINK_COMM.sha256"
          BIOS_HASH_LINK_COMM="$BIOS_LINK_COMM.sha256"
          EC_SIGN_LINK_COMM="$EC_LINK_COMM.sha256.sig"
          BIOS_SIGN_LINK_COMM="$BIOS_LINK_COMM.sha256.sig"
          PLATFORM_SIGN_KEY="customer-keys/novacustom/novacustom-open-source-firmware-release-1.x-key.asc"
          NEED_SMBIOS_MIGRATION="false"
          NEED_SMMSTORE_MIGRATION="true"
          NEED_BLOB_TRANSMISSION="false"
          PROGRAMMER_BIOS="internal"
          PROGRAMMER_EC="ite_ec"
          FLASHROM_ADD_OPT_DEPLOY="--ifd -i bios"
          if check_if_dasharo; then
          # if v1.7.2 or older, flash the whole bios region, as per:
          # TBD
            compare_versions $DASHARO_VERSION 1.7.2
            if [ $? -eq 1 ]; then
              # For Dasharo version lesser than 1.7.2
              NEED_BOOTSPLASH_MIGRATION="true"
              FLASHROM_ADD_OPT_UPDATE="--ifd -i bios"
            else
              # For Dasharo version greater or equal 1.7.2
              FLASHROM_ADD_OPT_UPDATE="--fmap -i RW_SECTION_A"
            fi
          fi
          ;;
        "NV4xPZ")
          DASHARO_REL_NAME="novacustom_nv4x_adl"
          DASHARO_REL_VER="1.7.2"
          BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}.rom"
          EC_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_ec_v${DASHARO_REL_VER}.rom"
          HAVE_EC="true"
          NEED_EC_RESET="true"
          COMPATIBLE_EC_FW_VERSION="2022-08-31_cbff21b"
          EC_HASH_LINK_COMM="$EC_LINK_COMM.sha256"
          BIOS_HASH_LINK_COMM="$BIOS_LINK_COMM.sha256"
          EC_SIGN_LINK_COMM="$EC_LINK_COMM.sha256.sig"
          BIOS_SIGN_LINK_COMM="$BIOS_LINK_COMM.sha256.sig"
          PLATFORM_SIGN_KEY="customer-keys/novacustom/novacustom-open-source-firmware-release-1.x-key.asc"
          NEED_SMBIOS_MIGRATION="false"
          NEED_SMMSTORE_MIGRATION="true"
          NEED_BOOTSPLASH_MIGRATION="false"
          NEED_BLOB_TRANSMISSION="false"
          PROGRAMMER_BIOS="internal"
          PROGRAMMER_EC="ite_ec"
          FLASHROM_ADD_OPT_DEPLOY="--ifd -i bios"
          if check_if_dasharo; then
          # if v1.7.2 or older, flash the whole bios region, as per:
          # TBD
            compare_versions $DASHARO_VERSION 1.7.2
            if [ $? -eq 1 ]; then
              # For Dasharo version lesser than 1.7.2
              NEED_BOOTSPLASH_MIGRATION="true"
              FLASHROM_ADD_OPT_UPDATE="--ifd -i bios"
            else
              # For Dasharo version greater or equal 1.7.2
              FLASHROM_ADD_OPT_UPDATE="--fmap -i RW_SECTION_A"
            fi
          fi
          ;;
        *)
          error_exit "Board model $SYSTEM_MODEL is currently not supported"
          ;;
      esac
      ;;
    "Micro-Star International Co., Ltd.")
      case "$SYSTEM_MODEL" in
        "MS-7D25")
          case "$BOARD_MODEL" in
            "PRO Z690-A WIFI DDR4(MS-7D25)" | "PRO Z690-A DDR4(MS-7D25)")
              DASHARO_REL_NAME="msi_ms7d25"
              DASHARO_REL_VER="1.1.1"
              DASHARO_REL_VER_DES="1.1.2"
              BIOS_LINK_COMM="${FW_STORE_URL}/${DASHARO_REL_NAME}/v${DASHARO_REL_VER}/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}_ddr4.rom"
              BIOS_LINK_DES="${FW_STORE_URL_DES}/MS-7D25/v${DASHARO_REL_VER_DES}/${DASHARO_REL_NAME}_v${DASHARO_REL_VER_DES}_ddr4.rom"
              HAVE_EC="false"
              NEED_EC_RESET="false"
              BIOS_HASH_LINK_COMM="${BIOS_LINK_COMM}.sha256"
              BIOS_HASH_LINK_DES="${BIOS_LINK_DES}.sha256"
              BIOS_SIGN_LINK_COMM="${BIOS_LINK_COMM}.sha256.sig"
              BIOS_SIGN_LINK_DES="${BIOS_LINK_DES}.sha256.sig"
              PLATFORM_SIGN_KEY="dasharo/msi_ms7d25/dasharo-release-1.x-compatible-with-msi-ms-7d25-signing-key.asc"
              NEED_SMBIOS_MIGRATION="true"
              NEED_SMMSTORE_MIGRATION="true"
              NEED_BOOTSPLASH_MIGRATION="false"
              NEED_BLOB_TRANSMISSION="false"
              PROGRAMMER_BIOS="internal"
              PROGRAMMER_EC=""
              FLASHROM_ADD_OPT_DEPLOY="--ifd -i bios"
              if check_if_dasharo; then
                # if v1.1.1 or older, flash the whole bios region, as per:
                # https://docs.dasharo.com/variants/msi_z690/firmware-update/#version-older-than-v110
                compare_versions $DASHARO_VERSION 1.1.2
                if [ $? -eq 1 ]; then
                # For Dasharo version lesser than 1.1.2
                    NEED_BOOTSPLASH_MIGRATION="true"
                    FLASHROM_ADD_OPT_UPDATE="--ifd -i bios"
                else
                # For Dasharo version greater or equal 1.1.2
                    FLASHROM_ADD_OPT_UPDATE="--fmap -i RW_SECTION_A -i RW_SECTION_B"
                fi
              fi
              ;;
            "PRO Z690-A WIFI (MS-7D25)" | "PRO Z690-A (MS-7D25)")
              DASHARO_REL_NAME="msi_ms7d25"
              DASHARO_REL_VER="1.1.1"
              DASHARO_REL_VER_DES="1.1.2"
              BIOS_LINK_COMM="${FW_STORE_URL}/${DASHARO_REL_NAME}/v${DASHARO_REL_VER}/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}_ddr5.rom"
              BIOS_LINK_DES="${FW_STORE_URL_DES}/MS-7D25/v${DASHARO_REL_VER_DES}/${DASHARO_REL_NAME}_v${DASHARO_REL_VER_DES}_ddr5.rom"
              HAVE_EC="false"
              NEED_EC_RESET="false"
              BIOS_HASH_LINK_COMM="${BIOS_LINK_COMM}.sha256"
              BIOS_HASH_LINK_DES="${BIOS_LINK_DES}.sha256"
              BIOS_SIGN_LINK_COMM="${BIOS_LINK_COMM}.sha256.sig"
              BIOS_SIGN_LINK_DES="${BIOS_LINK_DES}.sha256.sig"
              PLATFORM_SIGN_KEY="dasharo/msi_ms7d25/dasharo-release-1.x-compatible-with-msi-ms-7d25-signing-key.asc"
              NEED_SMBIOS_MIGRATION="true"
              NEED_SMMSTORE_MIGRATION="true"
              NEED_BOOTSPLASH_MIGRATION="false"
              NEED_BLOB_TRANSMISSION="false"
              PROGRAMMER_BIOS="internal"
              PROGRAMMER_EC=""
              FLASHROM_ADD_OPT_DEPLOY="--ifd -i bios"
              if check_if_dasharo; then
                # if v1.1.1 or older, flash the whole bios region, as per:
                # https://docs.dasharo.com/variants/msi_z690/firmware-update/#version-older-than-v110
                compare_versions $DASHARO_VERSION 1.1.2
                if [ $? -eq 1 ]; then
                # For Dasharo version lesser than 1.1.2
                    NEED_BOOTSPLASH_MIGRATION="true"
                    FLASHROM_ADD_OPT_UPDATE="--ifd -i bios"
                else
                # For Dasharo version greater or equal 1.1.2
                    FLASHROM_ADD_OPT_UPDATE="--fmap -i RW_SECTION_A -i RW_SECTION_B"
                fi
              fi
              ;;
            *)
              error_exit "Board model $BOARD_MODEL is currently not supported"
              ;;
          esac
          ;;
        "MS-7E06")
          case "$BOARD_MODEL" in
            "PRO Z790-P WIFI DDR4(MS-7E06)" | "PRO Z790-P DDR4(MS-7E06)")
              DASHARO_REL_NAME="msi_ms7e06"
              #DASHARO_REL_VER=""
              DASHARO_REL_VER_DES="0.9.0"
              #BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}_ddr4.rom"
              BIOS_LINK_DES="${FW_STORE_URL_DES}/MS-7E06/v${DASHARO_REL_VER_DES}/${DASHARO_REL_NAME}_v${DASHARO_REL_VER_DES}_ddr4.rom"
              HAVE_EC="false"
              NEED_EC_RESET="false"
              #BIOS_HASH_LINK_COMM="${BIOS_LINK_COMM}.sha256"
              BIOS_HASH_LINK_DES="${BIOS_LINK_DES}.sha256"
              #BIOS_SIGN_LINK_COMM="${BIOS_LINK_COMM}.sha256.sig"
              BIOS_SIGN_LINK_DES="${BIOS_LINK_DES}.sha256.sig"
              PLATFORM_SIGN_KEY="dasharo/msi_ms7e06/dasharo-release-0.x-compatible-with-msi-ms-7e06-signing-key.asc"
              NEED_SMBIOS_MIGRATION="false"
              NEED_SMMSTORE_MIGRATION="true"
              NEED_BOOTSPLASH_MIGRATION="false"
              NEED_BLOB_TRANSMISSION="false"
              PROGRAMMER_BIOS="internal"
              PROGRAMMER_EC=""
              FLASHROM_ADD_OPT_DEPLOY="-N --ifd -i bios"
              FLASHROM_ADD_OPT_READ="--ifd -i fd -i me -i bios"
              if ! check_if_dasharo; then
                NEED_ROMHOLE_MIGRATION="true"
              fi
              ;;
            "PRO Z790-P WIFI (MS-7E06)" | "PRO Z790-P (MS-7E06)")
              DASHARO_REL_NAME="msi_ms7e06"
              #DASHARO_REL_VER=""
              DASHARO_REL_VER_DES="0.9.0"
              #BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}_ddr5.rom"
              BIOS_LINK_DES="${FW_STORE_URL_DES}/MS-7E06/v${DASHARO_REL_VER_DES}/${DASHARO_REL_NAME}_v${DASHARO_REL_VER_DES}_ddr5.rom"
              HAVE_EC="false"
              NEED_EC_RESET="false"
              #BIOS_HASH_LINK_COMM="${BIOS_LINK_COMM}.sha256"
              BIOS_HASH_LINK_DES="${BIOS_LINK_DES}.sha256"
              #BIOS_SIGN_LINK_COMM="${BIOS_LINK_COMM}.sha256.sig"
              BIOS_SIGN_LINK_DES="${BIOS_LINK_DES}.sha256.sig"
              PLATFORM_SIGN_KEY="dasharo/msi_ms7e06/dasharo-release-0.x-compatible-with-msi-ms-7e06-signing-key.asc"
              NEED_SMBIOS_MIGRATION="false"
              NEED_SMMSTORE_MIGRATION="true"
              NEED_BOOTSPLASH_MIGRATION="false"
              NEED_BLOB_TRANSMISSION="false"
              PROGRAMMER_BIOS="internal"
              PROGRAMMER_EC=""
              FLASHROM_ADD_OPT_DEPLOY="-N --ifd -i bios"
              FLASHROM_ADD_OPT_READ="--ifd -i fd -i me -i bios"
              if ! check_if_dasharo; then
                NEED_ROMHOLE_MIGRATION="true"
              fi
              ;;
            *)
              error_exit "Board model $BOARD_MODEL is currently not supported"
              ;;
          esac
          ;;
        *)
          error_exit "Board model $SYSTEM_MODEL is currently not supported"
          ;;
      esac
      ;;
    "Dell Inc.")
      DASHARO_REL_NAME="dell_optiplex_9010"
      DASHARO_REL_VER="0.1.0"
      BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER.rom"
      HAVE_EC="false"
      NEED_EC_RESET="false"
      BIOS_HASH_LINK_COMM="a880504dfb0497f31e898f62ae5c9f3b145bca0b4fa601e41cddc54bea22ee36  $BIOS_UPDATE_FILE"
      NEED_SMBIOS_MIGRATION="true"
      NEED_BLOB_TRANSMISSION="true"
      PROGRAMMER_BIOS="internal"
      SINIT_ACM_FILENAME="/tmp/630744_003.zip"
      SINIT_ACM_URL="https://cdrdv2.intel.com/v1/dl/getContent/630744"
      SINIT_ACM_HASH="0b412c1832bd504d4b8f5fa01b32449c344fe0019e5e4da6bb5d80d393df5e8b $SINIT_ACM_FILENAME"
      SINIT_ACM="/tmp/630744_003/SNB_IVB_SINIT_20190708_PW.bin"
      FLASHROM_ADD_OPT_DEPLOY="--ifd -i bios"
      FLASHROM_ADD_OPT_UPDATE="--fmap -i RW_SECTION_A"
      case "$SYSTEM_MODEL" in
        "OptiPlex 7010")
          DBT_BIOS_UPDATE_FILENAME="/tmp/O7010A29.exe"
          DBT_BIOS_UPDATE_URL="https://dl.dell.com/FOLDER05066036M/1/O7010A29.exe"
          DBT_BIOS_UPDATE_HASH="ceb82586c67cd8d5933ac858c12e0cb52f6e0e4cb3249f964f1c0cfc06d16f52  $DBT_BIOS_UPDATE_FILENAME"
          DBT_UEFI_IMAGE="/tmp/_O7010A29.exe.extracted/65C10"
          SCH5545_FW="/tmp/_O7010A29.exe.extracted/65C10_output/pfsobject/section-7ec6c2b0-3fe3-42a0-a316-22dd0517c1e8/volume-0x50000/file-d386beb8-4b54-4e69-94f5-06091f67e0d3/section0.raw"
          ACM_BIN="/tmp/_O7010A29.exe.extracted/65C10_output/pfsobject/section-7ec6c2b0-3fe3-42a0-a316-22dd0517c1e8/volume-0x500000/file-2d27c618-7dcd-41f5-bb10-21166be7e143/object-0.raw"
          ;;
        "OptiPlex 9010")
          DBT_BIOS_UPDATE_FILENAME="/tmp/O9010A30.exe"
          DBT_BIOS_UPDATE_URL="https://dl.dell.com/FOLDER05066009M/1/O9010A30.exe"
          DBT_BIOS_UPDATE_HASH="b11952f43d0ad66f3ce79558b8c5dd43f30866158ed8348e3b2dae1bbb07701b  $DBT_BIOS_UPDATE_FILENAME"
          DBT_UEFI_IMAGE="/tmp/_O9010A30.exe.extracted/65C10"
          SCH5545_FW="/tmp/_O9010A30.exe.extracted/65C10_output/pfsobject/section-7ec6c2b0-3fe3-42a0-a316-22dd0517c1e8/volume-0x50000/file-d386beb8-4b54-4e69-94f5-06091f67e0d3/section0.raw"
          ACM_BIN="/tmp/_O9010A30.exe.extracted/65C10_output/pfsobject/section-7ec6c2b0-3fe3-42a0-a316-22dd0517c1e8/volume-0x500000/file-2d27c618-7dcd-41f5-bb10-21166be7e143/object-0.raw"
          ;;
        "Precision T1650")
          # tested on Dasharo Firmware for OptiPlex 9010, will need to be
          # enabled when build for T1650 exists
          #
          # DBT_BIOS_UPDATE_FILENAME="/tmp/T1650A28.exe"
          # DBT_BIOS_UPDATE_URL="https://dl.dell.com/FOLDER05065992M/1/T1650A28.exe"
          # DBT_BIOS_UPDATE_HASH="40a66210b8882f523885849c1d879e726dc58aa14718168b1e75f3e2caaa523b  $DBT_BIOS_UPDATE_FILENAME"
          # DBT_UEFI_IMAGE="/tmp/_T1650A28.exe.extracted/65C10"
          # SCH5545_FW="/tmp/_T1650A28.exe.extracted/65C10_output/pfsobject/section-7ec6c2b0-3fe3-42a0-a316-22dd0517c1e8/volume-0x60000/file-d386beb8-4b54-4e69-94f5-06091f67e0d3/section0.raw"
          # ACM_BIN="/tmp/_T1650A28.exe.extracted/65C10_output/pfsobject/section-7ec6c2b0-3fe3-42a0-a316-22dd0517c1e8/volume-0x500000/file-2d27c618-7dcd-41f5-bb10-21166be7e143/object-0.raw"
          print_warning "Dasharo Firmware for Precision T1650 not available yet!"
          error_exit "Board model $SYSTEM_MODEL is currently not supported"
          ;;
        *)
          error_exit "Board model $SYSTEM_MODEL is currently not supported"
          ;;
      esac
      ;;
    "ASUS")
      case "$SYSTEM_MODEL" in
        "KGPE-D16")
          DASHARO_REL_NAME="asus_kgpe-d16"
          DASHARO_REL_VER="0.4.0"
          HAVE_EC="false"
          NEED_EC_RESET="false"
          case "$FLASH_CHIP_SIZE" in
          "2")
            BIOS_HASH_LINK_COMM="65e5370e9ea6b8ae7cd6cc878a031a4ff3a8f5d36830ef39656b8e5a6e37e889  $BIOS_UPDATE_FILE"
            BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}_vboot_notpm.rom"
            ;;
          "8")
            BIOS_HASH_LINK_COMM="da4e6217d50f2ac199dcb9a927a0bc02aa4e792ed73c8c9bac8ba74fc787dbef  $BIOS_UPDATE_FILE"
            BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}_${FLASH_CHIP_SIZE}M_vboot_notpm.rom"
            ;;
          "16")
            BIOS_HASH_LINK_COMM="20055cf57185f149259706f58d5e9552a1589259c6617999c1ac7d8d3c960020  $BIOS_UPDATE_FILE"
            BIOS_LINK_COMM="$FW_STORE_URL/$DASHARO_REL_NAME/v$DASHARO_REL_VER/${DASHARO_REL_NAME}_v${DASHARO_REL_VER}_${FLASH_CHIP_SIZE}M_vboot_notpm.rom"
            ;;
          *)
            error_exit "Platform uses chipset with not supported size"
            ;;
          esac
          NEED_SMBIOS_MIGRATION="true"
          NEED_BLOB_TRANSMISSION="false"
          PROGRAMMER_BIOS="internal"
          ;;
        *)
          error_exit "Board model $SYSTEM_MODEL is currently not supported"
          ;;
      esac
      ;;
    *)
      error_exit "Board vendor: $BOARD_VENDOR is currently not supported"
      ;;
  esac
}

check_flash_lock() {
    flashrom -p "$PROGRAMMER_BIOS" ${FLASH_CHIP_SELECT} > /tmp/check_flash_lock 2> /tmp/check_flash_lock.err
    # Check in flashrom output if lock is enabled
    grep -q 'PR0: Warning:.* is read-only\|SMM protection is enabled' /tmp/check_flash_lock.err
    if [ $? -eq 0 ]; then
        print_warning "Flash lock enabled, please go into BIOS setup / Dasharo System Features / Dasharo\r
        \rSecurity Options and enable access to flash with flashrom.\r\n
        \rYou can learn more about this on: https://docs.dasharo.com/dasharo-menu-docs/dasharo-system-features/#dasharo-security-options"
        exit 1
    fi
}

check_flash_chip() {
  echo "Gathering flash chip and chipset information..."
  flashrom -p "$PROGRAMMER_BIOS" --flash-name >> "$FLASH_INFO_FILE" 2>> "$ERR_LOG_FILE"
  if [ $? -eq 0 ]; then
    echo -n "Flash information: "
    tail -n1 "$FLASH_INFO_FILE"
    FLASH_CHIP_SIZE=$(($(flashrom -p "$PROGRAMMER_BIOS" --flash-size 2>> /dev/null | tail -n1) / 1024 / 1024))
    echo -n "Flash size: "
    echo ${FLASH_CHIP_SIZE}M
  else
    for flash_name in $FLASH_CHIP_LIST
    do
      flashrom -p "$PROGRAMMER_BIOS" -c "$flash_name" --flash-name >> "$FLASH_INFO_FILE" 2>> "$ERR_LOG_FILE"
      if [ $? -eq 0 ]; then
        echo "Chipset found"
        tail -n1 "$FLASH_INFO_FILE"
        FLASH_CHIP_SELECT="-c ${flash_name}"
        FLASH_CHIP_SIZE=$(($(flashrom -p "$PROGRAMMER_BIOS" ${FLASH_CHIP_SELECT} --flash-size 2>> /dev/null | tail -n1) / 1024 / 1024))
        echo "Chipset size"
        echo ${FLASH_CHIP_SIZE}M
        break
      fi
    done
    if [ -z "$FLASH_CHIP_SELECT" ]; then
      error_exit "No supported chipset found, exit."
    fi
  fi
}

check_se_creds() {
  CLOUDSEND_LOGS_URL=$(sed -n '1p' < ${SE_credential_file} | tr -d '\n')
  CLOUDSEND_DOWNLOAD_URL=$(sed -n '2p' < ${SE_credential_file} | tr -d '\n')
  CLOUDSEND_PASSWORD=$(sed -n '3p' < ${SE_credential_file} | tr -d '\n')
  USER_DETAILS="$CLOUDSEND_DOWNLOAD_URL:$CLOUDSEND_PASSWORD"
  board_config
  TEST_LOGS_URL="https://cloud.3mdeb.com/index.php/s/${CLOUDSEND_LOGS_URL}/authenticate/showShare"

  if check_network_connection; then
    CHECK_DOWNLOAD_REQUEST_RESPONSE=$(curl -L -I -s -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$BIOS_LINK_DES" -o /dev/null -w "%{http_code}")
    CHECK_LOGS_REQUEST_RESPONSE=$(curl -L -I -s -f -H "$CLOUD_REQUEST" "$TEST_LOGS_URL" -o /dev/null -w "%{http_code}")
    if [ ${CHECK_DOWNLOAD_REQUEST_RESPONSE} -eq 200 ] && [ ${CHECK_LOGS_REQUEST_RESPONSE} -eq 200 ]; then
      return 0
    else
      echo ""
      return 1
    fi
  fi
}

compare_versions() {
    # return 1 if ver2 > ver1
    # return 0 otherwise

    # Use awk to drop any suffixes (-devX or -rcY) from the version strings, so
    # that only the major, minor, and patch versions are compared. If the
    # resulting versions are the same (ver1 equals ver2), then the one without
    # any suffix is considered to be the newer version.
    local ver1="$(echo $1 | awk -F '-' '{print $1}')"
    local ver2="$(echo $2 | awk -F '-' '{print $1}')"
    local suffix1="$(echo $1 | sed 's/^[0-9]*\.[0-9]*\.[0-9]*-*//')"
    local suffix2="$(echo $2 | sed 's/^[0-9]*\.[0-9]*\.[0-9]*-*//')"

    if [[ $ver1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ $ver2 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      IFS='.' read -r -a arr_ver1 <<< "$ver1"
      IFS='.' read -r -a arr_ver2 <<< "$ver2"

      if [ ${arr_ver2[0]} -lt ${arr_ver1[0]} ]; then
          return 0
      fi

      if [ ${arr_ver2[0]} -gt ${arr_ver1[0]} ]; then
          return 1
      fi

      if [ ${arr_ver2[0]} -eq ${arr_ver1[0]} ]; then
          if [ ${arr_ver2[1]} -lt ${arr_ver1[1]} ]; then
              return 0
          fi

          if [ ${arr_ver2[1]} -gt ${arr_ver1[1]} ]; then
              return 1
          fi

          if [ ${arr_ver2[1]} -eq ${arr_ver1[1]} ]; then
              if [ ${arr_ver2[2]} -lt ${arr_ver1[2]} ]; then
                return 0
              fi

              if [ ${arr_ver2[2]} -gt ${arr_ver1[2]} ]; then
                return 1
              fi

              # check suffixes
              if [ ! -z "$suffix2" ] && [ -z "$suffix1" ]; then
                return 0
              fi

              if [ -z "$suffix2" ] && [ ! -z "$suffix1" ]; then
                return 1
              fi
          fi
      fi
    else
      error_exit "Incorrect version format"
    fi
}

download_artifacts() {
  echo "Downloading Dasharo firmware..."
  if [ -v BIOS_LINK_COMM ] && [ ${BIOS_LINK} == ${BIOS_LINK_COMM} ]; then
    curl -s -L -f "$BIOS_LINK" -o $BIOS_UPDATE_FILE
    error_check "Cannot access $FW_STORE_URL while downloading binary. Please
   check your internet connection"
    curl -s -L -f "$BIOS_HASH_LINK" -o $BIOS_HASH_FILE
    error_check "Cannot access $FW_STORE_URL while downloading signature. Please
   check your internet connection"
    curl -s -L -f "$BIOS_SIGN_LINK" -o $BIOS_SIGN_FILE
    error_check "Cannot access $FW_STORE_URL while downloading signature. Please
   check your internet connection"
    if [ "$HAVE_EC" = "true" ]; then
      curl -s -L -f "$EC_LINK" -o "$EC_UPDATE_FILE"
      error_check "Cannot access $FW_STORE_URL while downloading binary. Please
     check your internet connection"
      curl -s -L -f "$EC_HASH_LINK" -o $EC_HASH_FILE
      error_check "Cannot access $FW_STORE_URL while downloading signature. Please
     check your internet connection"
      curl -s -L -f "$EC_SIGN_LINK" -o $EC_SIGN_FILE
      error_check "Cannot access $FW_STORE_URL while downloading signature. Please
     check your internet connection"
    fi
  else
    USER_DETAILS="$CLOUDSEND_DOWNLOAD_URL:$CLOUDSEND_PASSWORD"
    curl -s -L -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$BIOS_LINK" -o $BIOS_UPDATE_FILE
    error_check "Cannot access $FW_STORE_URL_DES while downloading binary.
   Please check your internet connection"
    curl -s -L -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$BIOS_HASH_LINK" -o $BIOS_HASH_FILE
    error_check "Cannot access $FW_STORE_URL_DES while downloading signature.
   Please check your internet connection"
    curl -s -L -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$BIOS_SIGN_LINK" -o $BIOS_SIGN_FILE
    error_check "Cannot access $FW_STORE_URL_DES while downloading signature.
   Please check your internet connection"
    if [ "$HAVE_EC" = "true" ]; then
      curl -s -L -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$EC_LINK" -o $EC_UPDATE_FILE
      error_check "Cannot access $FW_STORE_URL while downloading binary. Please
     check your internet connection"
      curl -s -L -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$EC_HASH_LINK" -o $EC_HASH_FILE
      error_check "Cannot access $FW_STORE_URL while downloading signature. Please
     check your internet connection"
      curl -s -L -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$EC_SIGN_LINK" -o $EC_SIGN_FILE
      error_check "Cannot access $FW_STORE_URL while downloading signature. Please
     check your internet connection"
    fi
  fi
}

download_keys() {
  mkdir $KEYS_DIR
  wget -O $KEYS_DIR/recovery_key.vbpubk https://github.com/Dasharo/vboot/raw/dasharo/tests/devkeys/recovery_key.vbpubk >> $ERR_LOG_FILE 2>&1
  wget -O $KEYS_DIR/firmware.keyblock https://github.com/Dasharo/vboot/raw/dasharo/tests/devkeys/firmware.keyblock >> $ERR_LOG_FILE 2>&1
  wget -O $KEYS_DIR/firmware_data_key.vbprivk https://github.com/Dasharo/vboot/raw/dasharo/tests/devkeys/firmware_data_key.vbprivk >> $ERR_LOG_FILE 2>&1
  wget -O $KEYS_DIR/kernel_subkey.vbpubk https://github.com/Dasharo/vboot/raw/dasharo/tests/devkeys/kernel_subkey.vbpubk >> $ERR_LOG_FILE 2>&1
  wget -O $KEYS_DIR/root_key.vbpubk https://github.com/Dasharo/vboot/raw/dasharo/tests/devkeys/root_key.vbpubk>> $ERR_LOG_FILE 2>&1
}

get_signing_keys() {
    echo "Getting platform specific GPG key... "
    wget -q https://raw.githubusercontent.com/3mdeb/3mdeb-secpack/master/$PLATFORM_SIGN_KEY -O - | gpg --import - >> $ERR_LOG_FILE 2>&1
    error_check "Cannot get platform specific key to verify signatures."
    print_green "Done"
}

verify_artifacts() {
  local _type="$1"
  local _update_file=""
  local _hash_file=""
  local _sign_file=""
  local _name=""
  case ${_type} in
    ec)
    _update_file=$EC_UPDATE_FILE
    _hash_file=$EC_HASH_FILE
    _sign_file=$EC_SIGN_FILE
    _name="Dasharo EC"
    ;;
    bios)
    _update_file=$BIOS_UPDATE_FILE
    _hash_file=$BIOS_HASH_FILE
    _sign_file=$BIOS_SIGN_FILE
    _name="Dasharo"
    ;;
    *)
    ;;
  esac
  echo "Checking $_name firmware checksum..."
  sha256sum --check <(echo $(cat $_hash_file | cut -d ' ' -f 1) $_update_file) >> $ERR_LOG_FILE 2>&1
  error_check "Failed to verify $_name firmware checksum"
  print_green "Done"
  if [ -v PLATFORM_SIGN_KEY ]; then
    echo "Checking $_name firmware signature..."
    (cat $_hash_file) | gpg --verify $_sign_file -
    error_check "Failed to verify $_name firmware signature."
  fi
  print_green "Done"
}
