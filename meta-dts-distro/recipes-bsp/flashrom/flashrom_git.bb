DESCRIPTION = "flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips"
LICENSE = "GPL-2.0-or-later"
HOMEPAGE = "http://flashrom.org"

LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

BRANCH="dasharo-release"
SRCREV = "9bddf6233d8eda26b0cbc508745fc9a7738c9e73"
SRC_URI = " \
    git://github.com/Dasharo/flashrom.git;branch=${BRANCH};protocol=https \
    file://0001-meson.build-correctly-access-build-options.patch \
"

S = "${WORKDIR}/git"

DEPENDS = "pciutils libusb libftdi"

inherit meson pkgconfig
