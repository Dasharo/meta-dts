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
  [ "$_error_code" -ne 0 ] && error_exit "$_error_msg : ($_error_code)"
  _error_msg="$1"
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
