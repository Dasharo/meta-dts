SUMMARY = "AMT status checker for Linux"
HOMEPAGE = "https://github.com/mjg59/mei-amt-check"
SECTION = "tools"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=39f5702df600d6d1b1d6d138dc62347d"

PV = "1.0+git${SRCPV}"

SRC_URI = " \
            git://github.com/mjg59/mei-amt-check;protocol=https;branch=master \
            file://0001-Makefile-removed-setting-CC-variable.patch \
            "
SRCREV = "ec921d1e0a2ac770e7835589a28b85bc2f15200c"

S = "${WORKDIR}/git"

do_compile () {
    oe_runmake
}

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/mei-amt-check ${D}/${sbindir}
}
