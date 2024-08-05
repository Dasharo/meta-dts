require coreboot-utils.inc

SUMMARY = "\
          Provides information about the Intel CPU/chipset hardware \
          configuration (register contents, MSRs, etc).\
          "

DEPENDS += "pciutils zlib"

PV = "1.0+git${SRCPV}"

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

do_compile () {
  oe_runmake -C util/inteltool
}

do_install () {
  oe_runmake -C util/inteltool install
}
