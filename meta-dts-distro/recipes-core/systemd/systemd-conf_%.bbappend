FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://usb.network"

do_install:append() {
    install -D -m0644 ${WORKDIR}/usb.network ${D}${sysconfdir}/systemd/network/50-usb.network
}

FILES:${PN}:append = " ${sysconfdir}/systemd/network/50-usb.network"
