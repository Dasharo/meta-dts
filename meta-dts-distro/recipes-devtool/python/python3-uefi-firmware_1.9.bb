
SUMMARY = "Various data structures and parsing tools for UEFI firmware."
HOMEPAGE = "https://github.com/theopolis/uefi-firmware-parser"
AUTHOR = "Teddy Reed <teddy@prosauce.org>"
LICENSE = "BSD-2-Clause & BSD-3-Clause"
LIC_FILES_CHKSUM = "file://setup.py;md5=90fa5bae1547550f1c1993f651eda955"

SRC_URI = "https://files.pythonhosted.org/packages/7e/b4/a4ec646d24a1aad709fdb83de6e5eddd6cb24faec02f3a94a3af3b0aba28/uefi_firmware-1.9.tar.gz"
SRC_URI[md5sum] = "ee5011b4d0bcb0eb7c06295e0107894f"
SRC_URI[sha256sum] = "234119dd92780c67cce3b664e86119c41d0b2af188d7f372b69789b32c5d5cd0"

S = "${WORKDIR}/uefi_firmware-1.9"

RDEPENDS_${PN} = ""

inherit setuptools3
