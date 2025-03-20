FILESEXTRAPATHS:prepend := "${THISDIR}/grub-efi-custom:"

RDEPENDS:${PN}:remove = " virtual-grub-bootconf"

do_deploy:append () {
    # deploy all UEFI SB related bootfiles to later use them with bootimg-efi
    # wic plugin
    install -d ${DEPLOY_DIR_IMAGE}/bootfiles
    cp -r ${D}/boot/* ${DEPLOY_DIR_IMAGE}/bootfiles/
    # remove default grub-efi-grubx64.efi file deployed by .bb from poky; when
    # it is left in deploydir, bootimg-efi plugin picks it up after cloning
    # files from IMAGE_EFI_BOOT_FILES list
    # see: https://git.yoctoproject.org/poky/tree/scripts/lib/wic/plugins/source/bootimg-efi.py?id=00c04394cbc5ecaced7cc1bc8bc8787e621f987d#n360
    rm -rf ${DEPLOYDIR}/${GRUB_IMAGE_PREFIX}${GRUB_IMAGE}
}

do_deploy[nostamp] = "1"
