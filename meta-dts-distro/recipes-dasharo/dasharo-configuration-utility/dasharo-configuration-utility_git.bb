SUMMARY = "Dasharo Configuration Utility (DCU)"
HOMEPAGE = "https://github.com/Dasharo/dcu"
SECTION = "tools"

LICENSE = "Apache-2.0"

LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

PV = "0.2.1+git${SRCPV}"

SRC_URI = " \
    git://github.com/Dasharo/dcu.git;protocol=https;branch=main \
"

SRCREV = "6817e69d8eab55bc72725a3be4a8627b8d71c31b"

S = "${WORKDIR}/git"

RDEPENDS:${PN} = " \
    bash \
    cbfstool \
    imagemagick \
    util-linux \
"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/dcu ${D}/${sbindir}
}
