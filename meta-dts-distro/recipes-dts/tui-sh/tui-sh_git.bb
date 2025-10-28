SUMMARY = "TUI library"
HOMEPAGE = "https://github.com/3mdeb/tui-sh"
SECTION = "tools"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

PV = "0.1+git${SRCPV}"

SRC_URI = "git://github.com/3mdeb/tui-sh;protocol=https;branch=dts"
SRCREV = "7b65ae059d0ba088b24578aef1bb08a5620fc267"

S = "${WORKDIR}/git"

FILES:${PN} += "${libdir}/tui"
RDEPENDS:${PN} = " \
    bash \
    jq \
    yq \
"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -Dm 644 "${S}/lib/tui-lib.sh" "${D}${libdir}/tui/tui-lib.sh"
}
