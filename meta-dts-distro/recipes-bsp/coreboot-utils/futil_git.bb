SUMMARY = "\
          Firmware utility tool, used to create, sign, and validate Chrome \
          OS images."

HOMEPAGE = "https://github.com/Dasharo/vboot"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=562c740877935f40b262db8af30bca36"

DEPENDS += " \
    openssl \
    flashrom \
"

PV = "1.0+git${SRCPV}"

SRC_URI = " \
          git://github.com/Dasharo/vboot.git;protocol=https;branch=dasharo \
          file://0001-Makefile-disable-deprecated-warnigs-as-errors.patch \
          "
SRCREV = "dc68f9f1b56d92f76026dca490e79493599ff4cf"

S = "${WORKDIR}/git"

inherit pkgconfig

TARGET_CC_ARCH += "${LDFLAGS}"

RDEPENDS:${PN} += " \
    bash \
"

EXTRA_OEMAKE = " \
    DESTDIR="${D}" \
    PREFIX="${prefix}" \
"

INSANE_SKIP:${PN} = "textrel"

do_compile() {
  oe_runmake futil
}

do_install() {
    # we only install futility binary and couple of scripts that are used by
    # dasharo-deploy script
    install -d ${D}/${sbindir}
    install -d ${D}/${bindir}
    install -m 755 ${S}/build/futility/futility ${D}/${bindir}
    install ${S}/scripts/image_signing/resign_firmwarefd.sh ${D}/${sbindir}
    install ${S}/scripts/image_signing/common_minimal.sh ${D}/${sbindir}
    install ${S}/scripts/image_signing/sign_firmware.sh ${D}/${sbindir}
}
