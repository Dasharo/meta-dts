# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

SUMMARY = "Firmware analysis tool"
HOMEPAGE = "https://github.com/OSPG/binwalk"
# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=65bbee055d3ea3bfc475f07aecf4de64"

PV = "2.4.2+git${SRCPV}"
SRC_URI = "git://github.com/OSPG/binwalk;protocol=https;branch=master"
# Modify these as desired
SRCREV = "3dd13d7fd890f662ac6c75344906ebe50524200e"

S = "${WORKDIR}/git"

inherit setuptools3

# WARNING: the following rdepends are determined through basic analysis of the
# python sources, and might not be 100% accurate.
RDEPENDS:${PN} += "python3-core"
