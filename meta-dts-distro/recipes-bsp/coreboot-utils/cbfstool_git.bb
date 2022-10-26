require coreboot-utils.inc

SRC_URI += " \
    file://0001-.gitmodules-Switch-to-HTTPS-links.patch \
"

TARGET_CC_ARCH += "${LDFLAGS}"

EXTRA_OEMAKE = " \
    DESTDIR="${D}" \
    PREFIX="${prefix}" \
"

do_configure:prepend () {
    cd ${S}
    git submodule update --init 3rdparty/vboot
    cd -
}

do_compile () {
    oe_runmake -C util/cbfstool cbfstool
}

do_install () {
    install -d ${D}/${sbindir}
    install ${S}/util/${PN}/${PN} ${D}/${sbindir}
}
