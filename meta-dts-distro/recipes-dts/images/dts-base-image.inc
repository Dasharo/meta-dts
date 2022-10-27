DESCRIPTION = "dts image"

IMAGE_FEATURES += "ssh-server-openssh"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL:append = " \
  packagegroup-dts-system \
  packagegroup-dts-tests \
  packagegroup-dts-tools-base \
  packagegroup-dts-tools-ce \
"
# to avoid getting to IP's - we use DHCP in networkctl already
IMAGE_INSTALL:remove = "dhcpcd"

# Enable local auto-login of the root user (local = serial port and
# virtual console)
DTS_LOCAL_GETTY ?= " \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/serial-getty@.service \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/getty@.service \
"
local_autologin () {
    sed -e 's/^\(ExecStart *=.*getty \)/\1--autologin root --login-program \/usr\/sbin\/dts /' -i ${DTS_LOCAL_GETTY}
}

ROOTFS_POSTPROCESS_COMMAND += "local_autologin; "
