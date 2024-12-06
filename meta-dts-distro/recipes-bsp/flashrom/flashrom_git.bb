SUMMARY = "flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips"
HOMEPAGE = "http://flashrom.org"

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

DEPENDS = "pciutils libusb libftdi"

PV = "dasharo-v1.2.2+git${SRCPV}"

BRANCH = "dasharo-release"
SRC_URI = "git://github.com/Dasharo/flashrom.git;branch=${BRANCH};protocol=https"
SRCREV = "a961af7a39138216660b410a4a0bec48ef0fdd35"

S = "${WORKDIR}/git"

inherit meson pkgconfig
