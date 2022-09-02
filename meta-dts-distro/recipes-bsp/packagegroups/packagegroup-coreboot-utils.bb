SUMMARY = "coreboot-utils packagegroup"
DESCRIPTION = "coreboot-utils packagegroup"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = " \
  packagegroup-coreboot-utils \
"

RDEPENDS:${PN} = " \
  ectool \
  ifdtool \
  superiotool \
  inteltool \
  msrtool \
  intelp2m \
  nvramtool \
"
