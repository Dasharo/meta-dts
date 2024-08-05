require coreboot-utils.inc

SUMMARY = "Dump interesting things about Management Engine even if hidden"

DEPENDS += "pciutils zlib"

PV = "1.0+git${SRCPV}"

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

TARGET_CFLAGS += "-I../../src/commonlib/bsd/include"

do_compile () {
  oe_runmake -C util/intelmetool
}

do_install () {
  oe_runmake -C util/intelmetool install
}
