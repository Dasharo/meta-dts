require ${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', 'grub-efi-efi-custom.inc', '', d)}
