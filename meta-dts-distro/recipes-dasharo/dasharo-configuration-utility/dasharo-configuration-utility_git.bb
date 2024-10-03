SUMMARY = "Dasharo Configuration Utility (DCU)"
HOMEPAGE = "https://github.com/Dasharo/dcu"
SECTION = "tools"

LICENSE = "Apache-2.0"

LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

SRC_URI = " \
    git://github.com/Dasharo/dcu.git;protocol=https;branch=main \
"

SRCREV = "647a5147e5b2914cc92111367c725f888dd37a77"

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
