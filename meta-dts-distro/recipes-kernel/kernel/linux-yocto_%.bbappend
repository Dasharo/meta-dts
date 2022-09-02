FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://dts.cfg \
    file://touchpad.cfg \
"
