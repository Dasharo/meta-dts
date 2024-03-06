DESCRIPTION = "sbctl - a simple tool"
HOMEPAGE = "https://github.com/foxboron/sbctl.git"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=16d98588b73d8e0dcc069d319889da4c"

SRC_URI = "https://github.com/Foxboron/${BPN}/releases/download/${PV}/${BPN}-${PV}-linux-amd64.tar.gz"
SRC_URI[sha256sum] = "7ed132eacb70835f84efa3ad58d47b15fa8731b22333968b8a17876826880666"

S = "${WORKDIR}/${BPN}"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${S}/sbctl ${D}${bindir}/
}

