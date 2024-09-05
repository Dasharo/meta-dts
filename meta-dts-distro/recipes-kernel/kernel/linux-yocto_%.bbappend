FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://acpi-bgrt.cfg \
    file://dts.cfg \
    file://enable-memconsole-coreboot.cfg \
    file://intel-mei.cfg \
    file://intel-other.cfg \
    file://intel-sound.cfg \
    file://iommu.cfg \
    file://serial-8250-dw.cfg \
    file://silence-terminal-logs.cfg \
    file://touchpad.cfg \
    file://tpm.cfg \
"

# Enable support for additional file systems:
SRC_URI:append = " \
    file://ntfs-enable.cfg \
    file://exfat-enable.cfg \
"

KERNEL_FEATURES:remove:x86 = " ${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', '${efi_secure_boot_sccs}', '', d)}"
KERNEL_FEATURES:remove:x86-64 = " ${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', '${efi_secure_boot_sccs}', '', d)}"
