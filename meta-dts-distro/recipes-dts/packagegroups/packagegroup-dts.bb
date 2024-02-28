SUMMARY = "dts packagegroup"
DESCRIPTION = "dts packagegroup"

LICENSE = "MIT"

inherit packagegroup

# disable sanity check for allarch packagegroup
PACKAGE_ARCH = ""

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
"

RDEPENDS:${PN}-tools-dts = " \
    packagegroup-security-tpm2 \
    libtss2 \
    libtss2-mu \
    libtss2-tcti-device \
    libtss2-tcti-mssim \
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
