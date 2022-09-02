require coreboot-utils.inc

S = "${WORKDIR}/git/util/msrtool"

export PREFIX = "${prefix}"

DEPENDS += "pciutils"

inherit autotools-brokensep
