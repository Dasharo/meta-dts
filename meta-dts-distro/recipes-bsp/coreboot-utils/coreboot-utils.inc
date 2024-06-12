DESCRIPTION = "coreboot tools"
SECTION = "coreboot"
HOMEPAGE = "https://doc.coreboot.org/util.html"

LICENSE = "LGPL-2.1-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = " \
    git://github.com/Dasharo/coreboot.git;protocol=https;branch=dasharo-4.21\
    "

SRCREV = "d08d5eaa98b1204b5e665d3ae4f63fb6f84a0d77"

S = "${WORKDIR}/git"
