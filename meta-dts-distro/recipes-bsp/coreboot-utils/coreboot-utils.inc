DESCRIPTION = "coreboot tools"
SECTION = "coreboot"
HOMEPAGE = "https://doc.coreboot.org/util.html"

LICENSE = "LGPL-2.1-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = " \
    git://github.com/Dasharo/coreboot.git;protocol=https;branch=dasharo\
    "

SRCREV = "5b6805c880e15aae40fdb1acd1ee994e97af8d79"

S = "${WORKDIR}/git"
