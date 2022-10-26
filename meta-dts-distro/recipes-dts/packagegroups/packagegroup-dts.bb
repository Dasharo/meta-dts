SUMMARY = "dts packagegroup"
DESCRIPTION = "dts packagegroup"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = " \
    ${PN}-python \
    ${PN}-system \
    ${PN}-tests \
    ${PN}-tools-base \
    ${PN}-tools-dts \
"

RDEPENDS:${PN}-system = " \
    packagegroup-core-boot \
    packagegroup-core-base-utils \
    ca-certificates \
    chrony \
    chronyc \
    gnupg \
    wget \
"

RDEPENDS:${PN}-tests = " \
    dts-tests \
"

RDEPENDS:${PN}-tools-base = " \
    packagegroup-coreboot-utils \
    packagegroup-core-tools-debug \
    bmap-tools \
    flashrom \
    fwupd \
"

RDEPENDS:${PN}-tools-dts = " \
    cloudsend \
    dasharo-deploy \
    dasharo-hcl-report \
    dts \
    system76-ectool \
"

RDEPENDS:${PN}-python = " \
    python3-binwalk \
    python3-uefi-firmware \
"
