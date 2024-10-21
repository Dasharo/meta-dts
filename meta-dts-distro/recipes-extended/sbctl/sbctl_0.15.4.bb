SUMMARY = "Secure Boot key manager"
HOMEPAGE = "https://github.com/foxboron/sbctl.git"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=16d98588b73d8e0dcc069d319889da4c"

SRC_URI = "https://github.com/Foxboron/${BPN}/releases/download/${PV}/${BPN}-${PV}-linux-amd64.tar.gz"
SRC_URI[sha256sum] = "5bc440637b25a78685f426441d195d92939b3ed82278220698159c68bcfd62c7"

S = "${WORKDIR}/${BPN}"

RDEPENDS:${PN} = "binutils util-linux-lsblk"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${S}/sbctl ${D}${bindir}/
}
