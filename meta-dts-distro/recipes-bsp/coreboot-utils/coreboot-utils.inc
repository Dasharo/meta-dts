DESCRIPTION = "coreboot tools"
SECTION = "coreboot"
HOMEPAGE = "https://doc.coreboot.org/util.html"

LICENSE = "LGPL-2.1-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = " \
    git://github.com/Dasharo/coreboot.git;protocol=https;branch=coreboot-utils-v2\
    "

SRCREV = "c10b38c4bcfb1623f77fa99e6dcdffbeadd56e90"

S = "${WORKDIR}/git"
