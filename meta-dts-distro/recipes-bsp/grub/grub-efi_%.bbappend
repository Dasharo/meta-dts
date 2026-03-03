FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
require ${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', 'grub-efi-efi-custom.inc', '', d)}

SRC_URI += " \
    file://grub.cfg \
    file://sbat.csv \
"

do_mkimage:append() {
    rm "./${GRUB_IMAGE_PREFIX}${GRUB_IMAGE}"
    grub-mkimage -v -c ../cfg -p ${EFIDIR} -d ./grub-core/ -s "${WORKDIR}/sbat.csv" \
                   -O ${GRUB_TARGET}-efi -o ./${GRUB_IMAGE_PREFIX}${GRUB_IMAGE} \
                   ${GRUB_MKIMAGE_MODULES}
}

do_install:append() {
    if [ -n "${D}" ]; then
        rm -rf "${D}${EFI_PREFIX}/"
    fi
}

do_deploy:append() {
    install -m 644 "${WORKDIR}/grub.cfg" "${DEPLOYDIR}/"
}

# This recipe creates grub-efi-bootx64.efi by default
# ("${GRUB_EFI_PREFIX}-${EFI_BOOT_IMAGE}")
# which is then copied to EFI/BOOT/BOOTX64.efi by build_hddimg and build_iso
# when building ISO image. This results in current bootx64 (shim) being
# overwritten. This workaround isn't needed if iso isn't added to IMAGE_FSTYPES.
EFI_BOOT_IMAGE = "grub${EFI_ARCH}.efi"
GRUB_BUILDIN:append = " probe regexp chain"
# We are using custom grub.cfg
RDEPENDS:${PN}:remove = "virtual-grub-bootconf"
