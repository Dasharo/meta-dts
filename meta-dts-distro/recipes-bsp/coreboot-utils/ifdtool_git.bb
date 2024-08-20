require coreboot-utils.inc

SUMMARY = "Extract and dump Intel Firmware Descriptor information"

TARGET_CC_ARCH += "${LDFLAGS}"

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

do_compile () {
  oe_runmake -C util/ifdtool
}

do_install () {
  oe_runmake -C util/ifdtool install
}
