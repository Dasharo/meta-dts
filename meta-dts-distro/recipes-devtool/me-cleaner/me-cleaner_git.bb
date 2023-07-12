SUMMARY = "Tool for partial deblobbing of Intel ME/TXE firmware images"
HOMEPAGE = "https://github.com/corna/me_cleaner"

LICENSE = "GPL-3.0-only & GPL-3.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

SRC_URI = "git://github.com/corna/me_cleaner;protocol=https;branch=master"

PV = "1.2+git${SRCPV}"
SRCREV = "43612a630c79f3bc6f2653bfe90dfe0b7b137e08"

S = "${WORKDIR}/git"

inherit setuptools3

RDEPENDS:${PN} += "python3-core python3-crypt"
