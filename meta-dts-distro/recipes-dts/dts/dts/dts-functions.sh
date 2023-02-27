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
