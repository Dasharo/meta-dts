require coreboot-utils.inc

SUMMARY = "CBMEM parser to read e.g. timestamps and console log"

DEPENDS += "pciutils zlib"

PV = "1.0+git${SRCPV}"

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

do_compile () {
  oe_runmake -C util/cbmem
}

do_install () {
  oe_runmake -C util/cbmem install
}
