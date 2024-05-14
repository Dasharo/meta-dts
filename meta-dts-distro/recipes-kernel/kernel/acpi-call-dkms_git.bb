SUMMARY = "A kernel simple module that enables you to call ACPI methods by writing the method name followed by arguments to /proc/acpi/call."
DESCRIPTION = "${SUMMARY}"

LICENSE = "GPL-3.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=025e46592215127e8c98b397ff29a037"

inherit module

SRC_URI = "git://github.com/nix-community/acpi_call.git;branch=master;protocol=https \
           file://0001-Makefile-fixing-build-errrors.patch \
           file://0001-GPLv3-licence-file-added.patch \
           "

SRCREV = "fe9dc95a83a95e4826c1a7c809d41c2f16de40a6"

S = "${WORKDIR}/git"

# On scarthgap, the kernel-module prefix was not added automatically anymore.
# The module was not packaged at all by default.
# PACKAGES += "kernel-module-acpi-call"
# FILES:kernel-module-acpi-call = "/${nonarch_base_libdir}/modules"

RPROVIDES:${PN} += "kernel-module-mdio-netlink"
MODULES_INSTALL_TARGET = "install"
KERNEL_MODULE_AUTOLOAD += "acpi_call"
