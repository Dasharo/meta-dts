DESCRIPTION = "Dasharo Tools Suite"
SECTION = "tools"
HOMEPAGE = "https://docs.dasharo.com"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
    file://dts \
    file://dts-boot \
    file://ec_transition \
    file://cloud_list \
    file://dts-environment.sh \
    file://dts-functions.sh \
    file://coreboot_customizer \
"

S = "${WORKDIR}"

RDEPENDS:${PN} = " \
    bash \
    dasharo-hcl-report \
    iotools \
"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/dts ${D}/${sbindir}
    install -m 0755 ${S}/dts-boot ${D}/${sbindir}
    install -m 0755 ${S}/ec_transition ${D}/${sbindir}
    install -m 0755 ${S}/cloud_list ${D}/${sbindir}
    install -m 0664 ${S}/dts-environment.sh ${D}/${sbindir}
    install -m 0664 ${S}/dts-functions.sh ${D}/${sbindir}
    install -m 0755 ${S}/coreboot_customizer ${D}/${sbindir}
}
