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
    3mdeb-secpack \
    packagegroup-core-boot \
    packagegroup-core-base-utils \
    ca-certificates \
    chrony \
    chronyc \
    efivar \
    gnupg \
    wget \
    ipxe-commands \
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
    me-cleaner \
    iperf3 \
"

RDEPENDS:${PN}-tools-dts = " \
    mei-amt-check \
    cloudsend \
    dasharo-deploy \
    dasharo-hcl-report \
    dts \
    dasharo-ectool \
    txt-suite \
    bg-suite \
    dasharo-configuration-utility \
"

RDEPENDS:${PN}-python = " \
    python3-binwalk \
    python3-uefi-firmware \
"
