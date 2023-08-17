SUMMARY = "TXT check script"
DESCRIPTION = "Script checks if Intel TXT can be used on a given system."
SECTION = "tools"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "file://txt-check"

S = "${WORKDIR}"

RDEPENDS:${PN} = " \
    bash  \
    busybox \
    gawk \
"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/${PN} ${D}/${sbindir}
}
