FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
require ${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', 'grub-efi-efi-custom.inc', '', d)}

SRC_URI += "file://grub.cfg"

do_deploy:append() {
    install -m 644 "${WORKDIR}/grub.cfg" ${DEPLOY_DIR_IMAGE}/
}

GRUB_BUILDIN:append = " probe regexp chain"
