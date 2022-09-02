SUMMARY = "A kernel simple module that enables you to call ACPI methods by writing the method name followed by arguments to /proc/acpi/call."
DESCRIPTION = "${SUMMARY}"

LICENSE = "CLOSED"

LICENSE = "LGPLv2 | LGPLv2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe"

inherit module

SRC_URI = "git://github.com/nix-community/acpi_call.git;branch=master;protocol=https \
           file://0001-Makefile-fixing-build-errrors.patch \
           file://0001-LGPLv2-licence-file-added.patch \
           "

SRCREV = "fe9dc95a83a95e4826c1a7c809d41c2f16de40a6"

S = "${WORKDIR}/git"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES:${PN} += "acpi_call"

KERNEL_MODULE_AUTOLOAD += "acpi_call"

do_install() {
    install -d ${D}/lib/modules/${KERNEL_VERSION}
    install ${S}/acpi_call.ko ${D}/lib/modules/${KERNEL_VERSION}
}
