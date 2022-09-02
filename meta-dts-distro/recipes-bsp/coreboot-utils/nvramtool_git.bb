require coreboot-utils.inc

EXTRA_OEMAKE = ' \
  DESTDIR="${D}" \
  PREFIX="${prefix}" \
'

do_compile () {
  oe_runmake -C util/nvramtool
}

do_install () {
  oe_runmake -C util/nvramtool install
}
