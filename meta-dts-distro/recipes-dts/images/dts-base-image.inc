DESCRIPTION = "dts image"

IMAGE_FEATURES += "ssh-server-openssh debug-tweaks"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL:append = " \
    packagegroup-dts-python \
    packagegroup-dts-system \
    packagegroup-dts-tests \
    packagegroup-dts-tools-base \
    packagegroup-dts-tools-dts \
    packagegroup-tpm-dts \
    libxcrypt-compat \
    alsa-utils-aplay \
    hw-probe \
    lshw \
"

# Enable local auto-login of the root user (local = serial port and
# virtual console)
DTS_LOCAL_GETTY ?= " \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/serial-getty@.service \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/getty@.service \
"
local_autologin () {
    sed -e 's/^\(ExecStart *=.*getty \)/\1--autologin root --login-program \/usr\/sbin\/dts-boot /' -i ${DTS_LOCAL_GETTY}
}

ROOTFS_POSTPROCESS_COMMAND += "local_autologin; "
