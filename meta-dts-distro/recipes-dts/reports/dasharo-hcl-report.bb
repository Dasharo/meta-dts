DESCRIPTION = "Dasharo HCL Report"
SECTION = "tools"
HOMEPAGE = "https://github.com/Dasharo/jubilant-octo-train/blob/master/config/includes.chroot/usr/bin/dasharo-hcl-report"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
  file://dasharo-hcl-report \
"

S = "${WORKDIR}"

RDEPENDS:${PN} = " \
  packagegroup-coreboot-utils \
  flashrom \
  iasl \
  tar \
  i2c-tools \
  i2c-tools-misc \
  bash \
  touchpad-info \
  dmidecode \
"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/dasharo-hcl-report ${D}/${sbindir}
}
