require coreboot-utils.inc

SUMMARY = "Dumps chipset-specific MSR registers."
DEPENDS += "pciutils"
PV = "1.0+git${SRCPV}"
S = "${WORKDIR}/git/util/msrtool"
export PREFIX = "${prefix}"
inherit autotools-brokensep
