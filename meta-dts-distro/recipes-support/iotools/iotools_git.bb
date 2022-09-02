DESCRIPTION = "The iotools package provides a set of simple command line tools \
               which allow access to hardware device registers. "
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = "git://github.com/adurbin/iotools;protocol=https;branch=master"

PV = "1.0+git${SRCPV}"
SRCREV = "18949fdc4dedb1da3f51ee83a582b112fb9f2c71"

S = "${WORKDIR}/git"

do_compile () {
    oe_runmake
}

do_install() {
    install -d ${D}/${sbindir}
    install ${S}/${PN} ${D}/${sbindir}
}
