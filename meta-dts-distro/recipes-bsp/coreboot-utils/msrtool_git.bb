require coreboot-utils.inc

SUMMARY = "Dumps chipset-specific MSR registers."
DEPENDS += "pciutils"
S = "${WORKDIR}/git/util/msrtool"
export PREFIX = "${prefix}"
inherit autotools-brokensep
