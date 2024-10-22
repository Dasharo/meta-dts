hostname = "DasharoToolsSuite"

do_install:append() {
    echo 'efivarfs /sys/firmware/efi/efivars efivarfs ro,nosuid,nodev,noexec,nofail 0 0' >> ${D}${sysconfdir}/fstab
}
