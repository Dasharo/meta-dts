DESCRIPTION = "Utility for generating TXE Secure Boot manifests"
LICENSE = "GPL-2.0-only"

SRC_URI = " \
git://github.com/Dasharo/coreboot.git;branch=txe_sb_tool;protocol=https \
"

SRCREV = "295c158e577400025d01e7ca8ad3beb64e1614a0"

LIC_FILES_CHKSUM = " \
file://${WORKDIR}/git/LICENSES/GPL-2.0-only.txt;md5=5430828348d2cf7d4b5e8395f774a68e \
"

S = "${WORKDIR}/git/util/txesbmantool"

inherit pkgconfig

DEPENDS = "wolfssl"


do_install() {
    oe_runmake 'DESTDIR=${D}' install
}

INSANE_SKIP:${PN} += "ldflags"

prefix = "/usr/local"
bindir = "${prefix}/bin"

FILES:${PN} += " \
   ${bindir}/txesbmantool \
"
