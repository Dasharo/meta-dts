DESCRIPTION = "flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips"
LICENSE = "GPL-2.0-or-later"
HOMEPAGE = "http://flashrom.org"

LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

BRANCH = "dasharo-release"
SRCREV = "81d507caa4e280289de458b9c615b71ddbcc4389"
SRC_URI = "git://github.com/Dasharo/flashrom.git;branch=${BRANCH};protocol=https"

S = "${WORKDIR}/git"

DEPENDS = "pciutils libusb libftdi"

inherit meson pkgconfig
