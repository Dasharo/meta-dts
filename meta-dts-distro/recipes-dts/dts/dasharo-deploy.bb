DESCRIPTION = "Dasharo Deploy Tools"
SECTION = "tools"
HOMEPAGE = "https://docs.dasharo.com"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
    file://dasharo-deploy \
"

S = "${WORKDIR}"

RDEPENDS:${PN} = " \
    bash \
    packagegroup-coreboot-utils \
"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/dasharo-deploy ${D}/${sbindir}
}
