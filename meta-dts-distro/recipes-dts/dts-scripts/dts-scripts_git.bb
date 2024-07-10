SUMMARY = "Dasharo Tools Suite scripts."
HOMEPAGE = "https://github.com/Dasharo/dts-scripts"
SECTION = "tools"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSES/Apache-2.0.txt;md5=c846ebb396f8b174b10ded4771514fcc  "

PV = "0.1+git${SRCPV}"

SRC_URI = "git://github.com/Dasharo/dts-scripts;protocol=https;branch=main"
SRCREV = "1932a7823e3a751ddc039068a6e7558ab4170d8d"

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