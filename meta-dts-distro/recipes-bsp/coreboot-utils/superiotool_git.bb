require coreboot-utils.inc

SUMMARY = "A user-space utility to detect Super I/O of a mainboard and provide detailed information about the register contents of the Super I/O. "

DEPENDS += "pciutils zlib"

PV = "1.0+git${SRCPV}"

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

do_compile () {
  oe_runmake -C util/superiotool
}

do_install () {
  oe_runmake -C util/superiotool install
}
