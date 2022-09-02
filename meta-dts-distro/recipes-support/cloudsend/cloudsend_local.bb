DESCRIPTION = "Bash script that uses curl to send files and folders to a nextcloud / owncloud publicly shared folder."
SECTION = "GPLv3"
HOMEPAGE = "https://github.com/tavinus/cloudsend.sh"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# we need to use local version of cloudsend.sh script as original does not
# properly check if the curl command ends with error (missing -f flag)
SRC_URI = "file://cloudsend.sh"

S = "${WORKDIR}"

RDEPENDS:${PN} = " \
  bash \
  curl \
"

do_install () {
    install -d ${D}/${bindir}
    install -m 0755 ${S}/cloudsend.sh ${D}/${bindir}
}
