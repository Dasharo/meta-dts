#!/usr/bin/env bash

# Text Reset
COLOR_OFF='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'

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

### Error checks
error_exit() {
  _error_msg="$1"
  print_error "$_error_msg"
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
  n="5"
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

check_se_creds() {
  CLOUDSEND_LOGS_URL=$(sed -n '1p' < ${SE_credential_file} | tr -d '\n')
  CLOUDSEND_DOWNLOAD_URL=$(sed -n '2p' < ${SE_credential_file} | tr -d '\n')
  CLOUDSEND_PASSWORD=$(sed -n '3p' < ${SE_credential_file} | tr -d '\n')
  USER_DETAILS="$CLOUDSEND_DOWNLOAD_URL:$CLOUDSEND_PASSWORD"
  CLOUD_REQUEST="X-Requested-With: XMLHttpRequest"
  TEST_DOWNLOAD_URL="https://cloud.3mdeb.com/public.php/webdav/biosupdate.rom"
  TEST_LOGS_URL="https://cloud.3mdeb.com/index.php/s/${CLOUDSEND_LOGS_URL}/authenticate/showShare"

  if check_network_connection; then
    CHECK_DOWNLOAD_REQUEST_RESPONSE=$(curl -L -I -s -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" "$TEST_DOWNLOAD_URL" -o /dev/null -w "%{http_code}")
    CHECK_LOGS_REQUEST_RESPONSE=$(curl -L -I -s -f -H "$CLOUD_REQUEST" "$TEST_LOGS_URL" -o /dev/null -w "%{http_code}")
    if [ ${CHECK_DOWNLOAD_REQUEST_RESPONSE} -eq 200 ] && [ ${CHECK_LOGS_REQUEST_RESPONSE} -eq 200 ]; then
      return 0
    else
      echo ""
      return 1
    fi
  fi
}
