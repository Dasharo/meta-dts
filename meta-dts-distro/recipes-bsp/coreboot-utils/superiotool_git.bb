require coreboot-utils.inc

DEPENDS += "pciutils zlib"

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
