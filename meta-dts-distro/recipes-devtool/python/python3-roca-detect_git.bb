SUMMARY = "ROCA key detector / fingerprinter tool"
HOMEPAGE = "https://github.com/crocs-muni/roca"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=2a6b12210371b9201fd100ff0cbef45a"

PV = "v1.2.12+git"

SRC_URI = "git://github.com/crocs-muni/roca;protocol=https;branch=master"
SRCREV = "df6071d502f68701427f8b1d409cab22055ad1b7"

S = "${WORKDIR}/git"

inherit setuptools3

RDEPENDS:${PN} += " \
    python3 \
    python3-cryptography \
    python3-six \
    python3-future \
    python3-coloredlogs \
    python3-pgpdump \
    python3-dateutil \
"
