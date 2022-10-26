SUMMARY = "coreboot-utils packagegroup"
DESCRIPTION = "coreboot-utils packagegroup"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = " \
    packagegroup-coreboot-utils \
"

RDEPENDS:${PN} = " \
    cbfstool \
    ectool \
    futil \
    ifdtool \
    intelp2m \
    inteltool \
    msrtool \
    nvramtool \
    superiotool \
"
