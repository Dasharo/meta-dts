DESCRIPTION = "coreboot tools"
SECTION = "coreboot"
HOMEPAGE = "https://doc.coreboot.org/util.html"

LICENSE = "LGPLv2 | LGPLv2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = " \
    git://github.com/Dasharo/coreboot.git;protocol=https;branch=coreboot-utils \
    "

SRCREV = "3ab63163007c0be7c8d93948f29a409055cda66c"

S = "${WORKDIR}/git"
