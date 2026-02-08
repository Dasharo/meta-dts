# nooelint: oelint.file.requirenotfound
require conf/image-uefi.conf
inherit deploy

SUMMARY = "UEFI shim loader"
HOMEPAGE = "https://github.com/rhboot/shim"
SECTION = "bootloaders"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=b92e63892681ee4e8d27e7a7e87ef2bc"

SRC_URI = "gitsm://github.com/rhboot/shim.git;protocol=https;branch=main"
SRCREV = "afc49558b34548644c1cd0ad1b6526a9470182ed"

S = "${WORKDIR}/git"

BACKSLASHES = "\\\\"

EXTRA_OEMAKE = "\
    CROSS_COMPILE=${TARGET_PREFIX} \
    LIB_GCC="`${CC} -print-libgcc-file-name`" \
    DEFAULT_LOADER=${BACKSLASHES}EFI${BACKSLASHES}DTS${BACKSLASHES}grub${EFI_ARCH}.efi \
"

do_configure() {
    oe_runmake clean
}

do_deploy() {
    install -Dm 0755 "${B}/shim${EFI_ARCH}.efi" "${DEPLOYDIR}/shim${EFI_ARCH}.efi"
    install -Dm 0755 "${B}/mm${EFI_ARCH}.efi" "${DEPLOYDIR}/mm${EFI_ARCH}.efi"
    install -Dm 0755 "${B}/fb${EFI_ARCH}.efi" "${DEPLOYDIR}/fb${EFI_ARCH}.efi"
    # Required by build_hddimg and build_iso.
    # More information in grub/grub-efi_%.bbappend
    install -Dm 0755 "${B}/shim${EFI_ARCH}.efi" "${DEPLOYDIR}/grub-efi-${EFI_BOOT_IMAGE}"
}

addtask deploy after do_compile
