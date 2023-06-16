require coreboot-utils.inc

DEPENDS += "pciutils zlib"

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
