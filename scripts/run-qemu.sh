#!/usr/bin/env bash

trap cleanup EXIT

set -e

cleanup() {
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        print_error "$BASH_COMMAND failed"
    fi

    if [ -f "${OVMF_VARS}" ]; then
        rm "${OVMF_VARS}"
    fi

    if [ -f "${TPM_DIR}/pid" ]; then
        kill "$(cat "${TPM_DIR}/pid")"
    fi
    if [ -d "${TPM_DIR}" ]; then
        rm -rf "${TPM_DIR}"
    fi

    exit $exit_code
}

print_help() {
cat <<EOF
$(basename "$0") [OPTION]... <image> [image]...
Run <image> in QEMU. Each image is mounted as separate drive.

Options:
  -k|--disable-kvm          Disable KVM in QEMU. DTS most likely won't boot.
  -e|--efi                  Use EFI BIOS
  -s|--secure-boot          Enable Secure Boot with EFI BIOS.
  -t|--tpm                  Add TPM2 device
  -n|--no-graphics          No graphic mode, only serial
  -m|--memory <mem>         How much RAM should QEMU have (default: 2G)
  -c|--cpu <cpu>            How many vCPUs should QEMU create (default: 4)
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
      -k|--disable-kvm)
        KVM=
        shift
        ;;
      -e|--efi)
        EFI="y"
        shift
        ;;
      -s|--secure-boot)
        EFI="y"
        SECBOOT="secboot."
        shift
        ;;
      -t|--tpm)
        TPM="y"
        shift
        ;;
      -n|--no-graphics)
        NO_GRAPHIC="-nographic"
        shift
        ;;
      -m|--memory)
        MEM="$2"
        shift 2
        ;;
      -c|--cpu)
        CPU="$2"
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
        POSITIONAL_ARGS+=( -drive "file=$1,if=ide,format=raw" )
        shift
        ;;
    esac
  done
}

POSITIONAL_ARGS=()
KVM="-enable-kvm"
MEM="2G"
CPU="4"
EFI=
SECBOOT=
TPM=
parse_args "$@"
set -- "${POSITIONAL_ARGS[@]}"

if [ $# -eq 0 ]; then
  print_usage_error "Script requires at least 1 positional argument, got 0"
fi

############################################

OVMF=()

if [ -n "$EFI" ]; then
    OVMF_VARS=$(mktemp --suffix=_OVMF_VARS)
    cp "/usr/share/OVMF/OVMF_VARS.${SECBOOT}fd" "${OVMF_VARS}"
    OVMF=(
        "-drive" "if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.${SECBOOT}fd"
        "-drive" "if=pflash,format=raw,file=${OVMF_VARS}"
    )
fi

if [ "$TPM" = "y" ]; then
    TPM_DIR=$(mktemp -d)
    TPM_ARGS=(
        -chardev "socket,id=chrtpm,path=${TPM_DIR}/sock"
        -tpmdev "emulator,id=tpm0,chardev=chrtpm"
        -device "tpm-tis,tpmdev=tpm0"
    )
    swtpm socket --tpm2 \
        --tpmstate dir="${TPM_DIR}" \
        --ctrl type=unixio,path="${TPM_DIR}/sock" \
        --pid file="${TPM_DIR}/pid" \
        --log level=5 &> "${TPM_DIR}/log" &
fi

qemu-system-x86_64 -serial mon:stdio -global ICH9-LPC.disable_s3=1 \
  "${OVMF[@]}" \
  -device virtio-net,netdev=vmnic \
  -netdev user,id=vmnic,hostfwd=tcp::5222-:22 \
  -m "$MEM" -smp "$CPU" -M q35 $KVM "${TPM_ARGS[@]}" $NO_GRAPHIC "${POSITIONAL_ARGS[@]}"
