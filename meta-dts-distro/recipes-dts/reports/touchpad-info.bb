SUMMARY = "Touchpad info script"
DESCRIPTION = "Gets information on the touchpad devices. Currently supports only Clevo devices"
SECTION = "tools"
HOMEPAGE = "https://github.com/3mdeb/fwdump-docker/blob/touchpad_info/scripts/get_touchpad_info.sh"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "file://touchpad-info"

S = "${WORKDIR}"

RDEPENDS:${PN} = " \
    bash  \
    i2c-tools \
    acpi-call-dkms \
"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/touchpad-info ${D}/${sbindir}
}
