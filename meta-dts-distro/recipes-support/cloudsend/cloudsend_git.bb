SUMMARY = "\
           Bash script that uses curl to send files and folders to a \
           nextcloud / owncloud publicly shared folder.\
           "

HOMEPAGE = "https://github.com/tavinus/cloudsend.sh"
SECTION = "GPLv3"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    git://github.com/tavinus/cloudsend.sh.git;protocol=https;branch=master \
    file://0001-cloudsend.sh-Add-fail-with-body-flag.patch \
    "

SRCREV = "65abbc6d809bcce13870dc5ea07937d324283173"

S = "${WORKDIR}/git"

RDEPENDS:${PN} = " \
    bash \
    curl \
"

do_install () {
    install -d ${D}/${bindir}
    install -m 0755 ${S}/cloudsend.sh ${D}/${bindir}
}
