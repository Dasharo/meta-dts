SUMMARY = "A package that provides Dasharo firmware for Novacustom V54/56 14th Gen"

HOMEPAGE = "https://dasharo.com/"

LICENSE = "GPL-2.0-only & GPL-3.0-only"

LIC_FILES_CHKSUM = " \
    file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464 \
    file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
"

SRC_URI = " \
    file://novacustom_v560tu_ec.rom \
    file://novacustom_v56x_mtl_v1.0.0.rom \
    file://novacustom_v540tu_ec.rom \
    file://novacustom_v54x_mtl_v1.0.0.rom \
    file://LICENSE \
    file://COPYING \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/dasharo-nc
    install -m 0644 ${WORKDIR}/novacustom_v560tu_ec.rom ${D}${sysconfdir}/dasharo-nc
    install -m 0644 ${WORKDIR}/novacustom_v56x_mtl_v1.0.0.rom ${D}${sysconfdir}/dasharo-nc
    install -m 0644 ${WORKDIR}/novacustom_v540tu_ec.rom ${D}${sysconfdir}/dasharo-nc
    install -m 0644 ${WORKDIR}/novacustom_v54x_mtl_v1.0.0.rom ${D}${sysconfdir}/dasharo-nc
}
