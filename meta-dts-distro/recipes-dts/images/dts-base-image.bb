require dts-base-image.inc
inherit uki

UKI_CMDLINE = "root=LABEL=${ROOT_LABEL} console=${KERNEL_CONSOLE} rootwait ${APPEND}"
UKI_FILENAME = "dts.efi"
IMAGE_EFI_BOOT_FILES += " \
    ${UKI_FILENAME};EFI/DTS/${UKI_FILENAME} \
    grub.cfg;EFI/BOOT/grub.cfg \
    "
