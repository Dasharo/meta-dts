SUMMARY = "iPXE commands autostart on boot"
HOMEPAGE = "https://github.com/Dasharo/meta-dts"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "file://ipxe-commands.service"

S = "${WORKDIR}"

do_install () {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${S}/ipxe-commands.service ${D}${systemd_unitdir}/system/
}

SYSTEMD_SERVICE:${PN} = " \
    ipxe-commands.service \
"

SYSTEMD_PACKAGES = " \
    ${PN} \
"

SYSTEMD_AUTO_ENABLE:${PN} = "enable"

inherit systemd
