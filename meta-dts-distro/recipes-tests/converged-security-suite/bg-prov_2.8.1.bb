SUMMARY = "Converged Security Suite's bg-prov"
HOMEPAGE = "https://github.com/9elements/converged-security-suite"
SECTION = "devel"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

SRC_URI = "https://github.com/9elements/converged-security-suite/releases/download/v${PV}/artifacts-amd64.zip"
SRC_URI[sha256sum] = "58362a5976e68c31e20ecd34338683826c920bb2f34c717dd693aecbb1f7db3d"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/bg-prov ${D}${bindir}
}

FILES:${PN} += "${bindir}/bg-prov"
