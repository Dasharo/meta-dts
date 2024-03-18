SUMMARY = "dts TPM packagegroup"
DESCRIPTION = "dts TPM packagegroup"

LICENSE = "MIT"

# disable sanity check for allarch packagegroup
# see: https://lists.openembedded.org/g/openembedded-core/message/158230
PACKAGE_ARCH = "${TUNE_PKGARCH}"

inherit packagegroup

RDEPENDS:${PN} = " \
    packagegroup-security-tpm2 \
    libtss2 \
    libtss2-mu \
    libtss2-tcti-device \
    libtss2-tcti-mssim \
"
