SUMMARY = "Dasharo Tools Suite scripts."
SECTION = "tools"
HOMEPAGE = "https://github.com/Dasharo/dts-v2"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=575ab8837c52eafc7b9eb8b244072bc7"

SRCREV = "13dad8ea6901cf921de0dd45d464bea3535892e0"
SRC_URI = "git://github.com/Dasharo/dts-v2;protocol=https;branch=main"

PV = "0.1+git${SRCPV}"

S = "${WORKDIR}/git"

RDEPENDS:${PN} = " \
    packagegroup-coreboot-utils \
    flashrom \
    iasl \
    tar \
    i2c-tools \
    i2c-tools-misc \
    bash \
    dmidecode \
    acpi-call-dkms \
    iotools \
"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${S}/scripts/dts ${D}/${sbindir}
    install -m 0755 ${S}/scripts/dts-boot ${D}/${sbindir}
    install -m 0755 ${S}/scripts/ec_transition ${D}/${sbindir}
    install -m 0755 ${S}/scripts/cloud_list ${D}/${sbindir}
    install -m 0755 ${S}/scripts/dasharo-deploy ${D}/${sbindir}
    install -m 0755 ${S}/reports/dasharo-hcl-report ${D}/${sbindir}
    install -m 0755 ${S}/reports/touchpad-info ${D}/${sbindir}
    install -m 0664 ${S}/include/dts-environment.sh ${D}/${sbindir}
    install -m 0664 ${S}/include/dts-functions.sh ${D}/${sbindir}

    # install profile dropin so the DTS_ENV and DTS_FUNCS variables are set when
    # loged via SSH
    install -d ${D}${sysconfdir}/profile.d/
    install -m 0755 ${S}/scripts/dts-profile.sh ${D}${sysconfdir}/profile.d/
}
