SUMMARY = "flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips"
HOMEPAGE = "http://flashrom.org"

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

DEPENDS = "pciutils libusb libftdi"

BRANCH = "dasharo-release"
SRC_URI = "git://github.com/Dasharo/flashrom.git;branch=${BRANCH};protocol=https"
SRCREV = "f5a48aa6c67bd30603062bb4265419fd49f83870"

S = "${WORKDIR}/git"

inherit meson pkgconfig
