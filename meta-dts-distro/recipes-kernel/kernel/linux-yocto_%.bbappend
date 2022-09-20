FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://dts.cfg \
    file://touchpad.cfg \
    file://enable-memconsole-coreboot.cfg \
    file://silence-terminal-logs.cfg \
"
