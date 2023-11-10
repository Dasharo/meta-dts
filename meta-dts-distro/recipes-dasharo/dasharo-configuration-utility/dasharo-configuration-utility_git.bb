DESCRIPTION = "Dasharo Configuration Utility (DCU)"
SECTION = "tools"
HOMEPAGE = "https://github.com/Dasharo/dcu"

LICENSE = "Apache-2.0"

LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

SRC_URI = " \
    git://github.com/Dasharo/dcu.git;protocol=https;branch=main \
"

SRCREV = "330fea6091a4658d4b37fc0c85cd5a39835e4043"

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
