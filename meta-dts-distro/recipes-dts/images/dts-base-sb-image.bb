require dts-base-image.inc

SUMMARY = "DTS base Secure Boot image"

IMAGE_INSTALL:append = " \
    util-linux \
    packagegroup-efi-secure-boot \
    kernel-initramfs \
    dnf \
    sbctl \
"

IMAGE_LINGUAS = " "

INITRAMFS_IMAGE ?= "secure-core-image-initramfs"
