#!/usr/bin/env bash

gen_common_ipxe() {
  local version="$1"
  cat <<EOF
#!ipxe
set dts_version ${version}
set dts_prefix \${dts_version}
iseq \${platform} efi && goto is_efi || goto not_efi
:not_efi

set path_kernel \${dts_prefix}/bzImage-\${dts_version}
set path_initrd \${dts_prefix}/dts-base-image-\${dts_version}.cpio.gz

imgfetch --name file_kernel \${path_kernel}
imgfetch --name file_initrd \${path_initrd}

kernel file_kernel initrd=file_initrd console=ttyUSB0
boot

:is_efi
EOF
}

gen_fum_workaround_ipxe() {
  gen_common_ipxe "$@"
  cat <<EOF
chain replace_fum_efivar.efi
imgfree
chain \${dts_prefix}/ipxe_dtsx64-\${dts_version}.efi
EOF
}

gen_without_fum_workaround_ipxe() {
  gen_common_ipxe "$@"
  echo "chain \${dts_prefix}/ipxe_dtsx64-\${dts_version}.efi"
}

VERSION=$1
RC_VER_PATTERN="v[0-9]+.[0-9]+.[0-9]+-rc[0-9]+$"
IPXE_FILE="dts.ipxe"
IPXE_RC_FILE="dts-rc.ipxe"
IPXE_NO_FUM_FIX_FILE="dts-no-fum-fix.ipxe"

if [ $# -ne 1 ]; then
  echo "Provide version, e.g. v1.2.3"
  exit
fi

# use different name for ipxe file when creating rc release
if [[ $VERSION =~ $RC_VER_PATTERN ]]; then
  IPXE_FILE=$IPXE_RC_FILE
fi

# imgverify can be enabled as a next step on top of the HTTPS. The imgtrust
# should already be executed in the embedded script on the device. Also, we
# should gracefully handle older firmware versions, where imgtrust and imgverify
# command could not be yet available.
# imgtrust --permanent
#
# set sig_kernel ${path_kernel}.sig
# set sig_initrd ${path_initrd}.sig
# imgverify file_kernel \${sig_kernel}
# imgverify file_initrd \${sig_initrd}

gen_fum_workaround_ipxe "${VERSION}" >"${IPXE_FILE}"
gen_without_fum_workaround_ipxe "${VERSION}" >"${IPXE_NO_FUM_FIX_FILE}"

if [ "${IPXE_FILE}" != "${IPXE_RC_FILE}" ]; then
  cp "${IPXE_FILE}" "${IPXE_RC_FILE}"
fi
