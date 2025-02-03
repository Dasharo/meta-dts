require dts-base-image.inc
inherit uki

UKI_CMDLINE = "root=LABEL=${ROOT_LABEL} console=${KERNEL_CONSOLE} rootwait ${APPEND}"
UKI_FILENAME = "dts.efi"
IMAGE_EFI_BOOT_FILES += " \
    ${UKI_FILENAME};EFI/DTS/${UKI_FILENAME} \
    grub.cfg;EFI/BOOT/grub.cfg \
    "

do_ipxe_uki() {
    stub="${DEPLOY_DIR_IMAGE}/linux${EFI_ARCH}.efi.stub"
    kernel="${DEPLOY_DIR_IMAGE}/${UKI_KERNEL_FILENAME}"
    rootfs="${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.cpio.gz"
    ukify build --cmdline "${UKI_CMDLINE}" --stub "${stub}" \
        --linux "${kernel}" --initrd "${rootfs}" \
        --tools "${RECIPE_SYSROOT_NATIVE}/lib/systemd/tools" \
        --os-release "${RECIPE_SYSROOT}/lib/os-release" \
        --output "${DEPLOY_DIR_IMAGE}/ipxe_${UKI_FILENAME}"
}

do_ipxe_uki[depends] += " \
    systemd-boot:do_deploy \
    virtual/kernel:do_deploy \
    dts-base-image:do_image_complete \
"

addtask ipxe_uki after do_image_complete before do_build
