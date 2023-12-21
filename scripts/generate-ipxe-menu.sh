#!/usr/bin/env bash

VERSION=$1
IPXE_FILE="dts.ipxe"

if [ $# -ne 1 ]; then
  echo "Provide version, e.g. v1.2.3"
  exit
fi

# imgverify can be enabled as a next step on top of the HTTPS. The imgtrust
# should already be executed in the embedded script on the device. Also, we
# should gracefuly handle older firmware versions, where imgtrust and imgverify
# command could not be yet available.
# imgtrust --permanent
#
# set sig_kernel ${path_kernel}.sig
# set sig_initrd ${path_initrd}.sig
# imgverify file_kernel \${sig_kernel}
# imgverify file_initrd \${sig_initrd}

cat <<EOF > "${IPXE_FILE}"
#!ipxe
set dts_version ${VERSION}
set dts_prefix \${dts_version}
set path_kernel \${dts_prefix}/bzImage-\${dts_version}
set path_initrd \${dts_prefix}/dts-base-image-\${dts_version}.cpio.gz

imgfetch --name file_kernel \${path_kernel}
imgfetch --name file_initrd \${path_initrd}

kernel file_kernel root=/dev/nfs initrd=file_initrd
boot
EOF
