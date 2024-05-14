SUMMARY = "Dasharo Tools Suite scripts."
SECTION = "tools"
HOMEPAGE = "https://github.com/Dasharo/dts-scripts"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSES/Apache-2.0.txt;md5=c846ebb396f8b174b10ded4771514fcc  "

SRCREV = "e59da61c2d8f1da39f5cb4138dddb0277b95a614"
SRC_URI = "git://github.com/Dasharo/dts-scripts;protocol=https;branch=main"

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
