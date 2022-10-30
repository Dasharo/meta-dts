#!/usr/bin/env bash

VERSION=$1
IPXE_FILE="dts.ipxe"

echo "#!ipxe" > ${IPXE_FILE}
echo "#" >> ${IPXE_FILE}
echo "kernel http://boot.dasharo.com/dts-ce/${VERSION}/bzImage-${VERSION} root=/dev/nfs initrd=dts-base-image-ce-${VERSION}.cpio.gz" >> ${IPXE_FILE}
echo "initrd http://boot.dasharo.com/dts-ce/${VERSION}/dts-base-image-ce-${VERSION}.cpio.gz" >> ${IPXE_FILE}
echo "boot" >> ${IPXE_FILE}
