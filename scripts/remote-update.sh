#!/usr/bin/env bash

trap cleanup EXIT

set -e

cleanup() {
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        print_error "$BASH_COMMAND failed"
    fi
    exit $exit_code
}

print_help() {
cat <<EOF
$(basename "$0") [OPTION]... [remote]
Copy dts-scripts to remote DTS. Copies to root@localhost on port 5222 by default

Options:
  -s|--script-dir <dir>     Path to dts-scripts directory
  -v|--verbose              Enable trace output
  -h|--help                 Print this help
EOF
}

print_usage_error() {
  print_help
  error_exit "$1"
}

print_error() {
  local red="\033[31m"
  local reset="\033[0m"
  echo -e "${red}ERROR: $1${reset}"
}

error_exit() {
  print_error "$1"
  exit 1
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -s|--script-dir)
        DTS_SCRIPTS="$(realpath "$2")"
        shift 2
        ;;
      -v|--verbose)
        set -x
        shift
        ;;
      -h|--help)
        print_help
        exit 0
        ;;
      -*)
        print_usage_error "Unknown option $1"
        ;;
      *)
        POSITIONAL_ARGS+=( "$1" )
        shift
        ;;
    esac
  done
}

POSITIONAL_ARGS=()
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
DTS_SCRIPTS="$(realpath "$SCRIPT_DIR/../../dts-scripts")"
parse_args "$@"
set -- "${POSITIONAL_ARGS[@]}"

if [ $# -gt 1 ]; then
  print_usage_error "Script accepts 0 or 1 arguments, got $#"
fi

############################################

if [ ! -d "$DTS_SCRIPTS" ]; then
    print_usage_error "$DTS_SCRIPTS doesn't exist, use --script-dir to set correct path"
fi

if [ -n "$1" ]; then
    REMOTE="$1"
    SCP="scp"
    SSH="ssh"
else
    REMOTE="root@localhost"
    SCP="scp -P 5222"
    SSH="ssh -p 5222"
fi

$SSH -q "$REMOTE" mkdir -p /tmp/dts-scripts
$SCP -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
    -r "$DTS_SCRIPTS"/* "$REMOTE":/tmp/dts-scripts
$SSH -q "$REMOTE" 'cd /tmp/dts-scripts && make'
