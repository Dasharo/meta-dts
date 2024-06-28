require coreboot-utils.inc

SUMMARY = "Dump interesting things about Management Engine even if hidden"

DEPENDS += "pciutils zlib"

SRC_URI += "file://hfsts6-check.sh"

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

TARGET_CFLAGS += "-I../../src/commonlib/bsd/include"

RDEPENDS:${PN} += "bash"

do_compile () {
  oe_runmake -C util/intelmetool
}

do_install () {
  oe_runmake -C util/intelmetool install
  install -d ${D}/${bindir}
  install -m 0755 ${WORKDIR}/hfsts6-check ${D}/${bindir}

}
