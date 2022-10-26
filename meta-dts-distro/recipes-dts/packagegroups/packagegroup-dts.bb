SUMMARY = "dts packagegroup"
DESCRIPTION = "dts packagegroup"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = " \
  ${PN}-system \
  ${PN}-tests \
  ${PN}-tools-base \
  ${PN}-tools-ce \
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
  tpm2-tools \
  libtss2 \
  mei-amt-check \
"

RDEPENDS:${PN}-tools-ce = " \
  dts \
  dasharo-hcl-report \
  cloudsend \
  system76-ectool \
"
