SUMMARY = "Dasharo Tools Suite scripts."
SECTION = "tools"
HOMEPAGE = "https://github.com/Dasharo/dts-v2"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=575ab8837c52eafc7b9eb8b244072bc7"

SRCREV = "c57dc8c60d73ccd0f540148e46be73221ecc67bb"
SRC_URI = "git://github.com/Dasharo/dts-v2;protocol=https;branch=main"

PV = "0.1+git${SRCPV}"

S = "${WORKDIR}/git"

RDEPENDS:${PN} = " \
    packagegroup-coreboot-utils \
    flashrom \
    iasl \
    tar \
    i2c-tools \
    i2c-tools-misc \
    bash \
    dmidecode \
    acpi-call-dkms \
    iotools \
"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    oe_runmake install DESTDIR="${D}"
}
