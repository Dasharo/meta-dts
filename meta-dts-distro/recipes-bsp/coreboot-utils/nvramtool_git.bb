require coreboot-utils.inc

SUMMARY = "Reads and writes coreboot parameters and displaying information from the coreboot table in CMOS/NVRAM. "

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

do_compile () {
  oe_runmake -C util/nvramtool
}

do_install () {
  oe_runmake -C util/nvramtool install
}
