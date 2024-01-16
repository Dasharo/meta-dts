DESCRIPTION = "sbctl - a simple tool"
HOMEPAGE = "https://github.com/foxboron/sbctl.git"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=16d98588b73d8e0dcc069d319889da4c"

SRC_URI = "file://sbctl-${PV}-linux-amd64.tar.gz"

S = "${WORKDIR}/${BPN}"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${S}/sbctl ${D}${bindir}/
}

