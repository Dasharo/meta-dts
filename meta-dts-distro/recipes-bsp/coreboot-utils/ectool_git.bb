require coreboot-utils.inc

EXTRA_OEMAKE = ' \
  DESTDIR="${D}" \
  PREFIX="${prefix}" \
'

do_compile () {
  oe_runmake -C util/ectool
}

do_install () {
  oe_runmake -C util/ectool install
}
