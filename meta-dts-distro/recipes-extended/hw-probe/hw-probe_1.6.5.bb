SUMMARY = "Tool to probe for hardware, check operability and find drivers"
HOMEPAGE = "https://github.com/linuxhw/hw-probe.git"
LICENSE = "LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68"

SRC_URI = "https://github.com/linuxhw/hw-probe/releases/download/1.6/hw-probe-1.6.5-189-x86_64.AppImage"

SRC_URI[sha256sum] = "dddec100c47b642c4bdd4f578b05bc8890c4f0ecbd0d5f15e965927590fad505"

S = "${WORKDIR}/${BPN}"

INSANE_SKIP:${PN} += "already-stripped"

FILES:${PN} += "/lib64"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/hw-probe-1.6.5-189-x86_64.AppImage ${D}${bindir}/hw-probe
    # make the link, since the appimage expects the libraries to be under /lib64
    ln -sr ${D}/${nonarch_base_libdir} ${D}/lib64
}
