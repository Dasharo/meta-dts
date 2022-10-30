SUMMARY = "coreboot-utils packagegroup"
DESCRIPTION = "coreboot-utils packagegroup"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = " \
    packagegroup-coreboot-utils \
"

RDEPENDS:${PN} = " \
    cbfstool \
    cbmem \
    ectool \
    futil \
    ifdtool \
    intelp2m \
    inteltool \
    intelmetool \
    msrtool \
    nvramtool \
    superiotool \
"
