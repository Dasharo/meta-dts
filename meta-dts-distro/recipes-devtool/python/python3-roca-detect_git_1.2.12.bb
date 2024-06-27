# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

SUMMARY = "ROCA key detector / fingerprinter tool"
HOMEPAGE = "https://github.com/crocs-muni/roca"
# NOTE: License in setup.py/PKGINFO is: MIT
# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=2a6b12210371b9201fd100ff0cbef45a"

SRC_URI = "git://github.com/crocs-muni/roca;protocol=https;branch=master"

# Modify these as desired
PV = "v1.2.12+git"
SRCREV = "df6071d502f68701427f8b1d409cab22055ad1b7"

S = "${WORKDIR}/git"

inherit setuptools3

# WARNING: the following rdepends are determined through basic analysis of the
# python sources, and might not be 100% accurate.
RDEPENDS:${PN} += "python3-compression python3-core python3-crypt python3-datetime python3-io python3-json python3-logging python3-math python3-netclient python3-unittest python3-future python3-coloredlogs"

# WARNING: We were unable to map the following python package/module
# dependencies to the bitbake packages which include them:
#    apk_parse.apk
#    coloredlogs
#    cryptography.hazmat.backends
#    cryptography.hazmat.backends.openssl.backend
#    cryptography.hazmat.backends.openssl.x509
#    cryptography.hazmat.primitives
#    cryptography.hazmat.primitives.asymmetric.rsa
#    cryptography.hazmat.primitives.serialization
#    cryptography.x509
#    cryptography.x509.base
#    cryptography.x509.oid
#    future.utils
#    jks
#    past.builtins
#    pgpdump.data
#    pgpdump.packet
#    pkg_resources
