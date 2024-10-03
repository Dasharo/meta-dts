DESCRIPTION = "coreboot tools"
HOMEPAGE = "https://doc.coreboot.org/util.html"
SECTION = "coreboot"

LICENSE = "LGPL-2.1-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = " \
          git://github.com/Dasharo/coreboot.git;protocol=https;branch=dasharo-4.21\
          "

SRCREV = "adb6e4ca14444eabd6b832dfbe990246cf629bcd"

S = "${WORKDIR}/git"
