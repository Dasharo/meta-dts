FILESEXTRAPATHS += "converged-security-suite/files"

DESCRIPTION = "Converged Security Suite's bg-suite"
HOMEPAGE = "https://github.com/9elements/converged-security-suite"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

SRC_URI = " \
    file://bg-suite \
"

SRC_URI[sha256sum] = "7d76040cf6d78bd1e5ccc9d0056799c37ccce0870139eef44a556f2e56a037e6"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/bg-suite ${D}${bindir}
}

INSANE_SKIP:${PN} = "ldflags"
