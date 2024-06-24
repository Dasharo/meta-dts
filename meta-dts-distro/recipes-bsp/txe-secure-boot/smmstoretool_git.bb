SUMMARY = "Offline SMMSTORE variable modification tool"
HOMEPAGE = "https://github.com/coreboot/coreboot"

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = " \
    file://${WORKDIR}/git/LICENSES/GPL-2.0-or-later.txt;md5=261bea1168c0bdfa73232ee90df11eb6 \
"

SRC_URI = " \
    git://github.com/coreboot/coreboot.git;branch=main;protocol=https \
    file://a5df001.diff;patchdir=${WORKDIR}/git \
"

SRCREV = "602653abed391ae1b1445ad86d0f05b8b5b678cb"

inherit pkgconfig

S = "${WORKDIR}/git/util/smmstoretool"

EXTRA_OEMAKE = ' \
                DESTDIR="${D}" \
                PREFIX="${prefix}" \
                '

do_install() {
    oe_runmake install
}

FILES:${PN} += " \
    ${bindir}/smmstoretool \
"
