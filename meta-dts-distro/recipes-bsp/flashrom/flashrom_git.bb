DESCRIPTION = "flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips"
LICENSE = "GPL-2.0-or-later"
HOMEPAGE = "http://flashrom.org"

LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

BRANCH = "rpl_support"
SRCREV = "e21d7ca298667db517dcfe493fed20b5a2e29251"
SRC_URI = "git://github.com/Dasharo/flashrom.git;branch=${BRANCH};protocol=https"

S = "${WORKDIR}/git"

DEPENDS = "pciutils libusb libftdi"

inherit meson pkgconfig
