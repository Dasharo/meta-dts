DESCRIPTION = "flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips"
LICENSE = "GPL-2.0-or-later"
HOMEPAGE = "http://flashrom.org"

LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

SRC_URI = "git://github.com/Dasharo/flashrom.git;branch=dasharo-develop;protocol=https"
SRCREV = "5618d826826f86f2d3eb3190c65baf3e2dac968f"

S = "${WORKDIR}/git"

inherit meson pkgconfig

# TODO: this verions of flashrom uses different switches than what's in the
# recipe v1.2
PACKAGECONFIG ??= "pci usb ftdi"
PACKAGECONFIG[ftdi] = ",,libftdi"
PACKAGECONFIG[pci] = "-Dpciutils=true,-Dpciutils=false,pciutils"
PACKAGECONFIG[usb] = "-Dusb=true,-Dusb=false,libusb"
