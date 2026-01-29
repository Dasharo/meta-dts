SUMMARY = "Local firmware binaries"
HOMEPAGE = "https://dl.3mdeb.com"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FW_STORE_URL ?= "https://dl.3mdeb.com/open-source-firmware/Dasharo"
BINARIES = " \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.1/novacustom_v54x_mtl_igpu_v1.0.1_btg_prod.rom;name=v540tu \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.1/novacustom_v54x_mtl_igpu_ec_v1.0.1.rom;name=v540tu-ec \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.1/novacustom_v56x_mtl_igpu_v1.0.1_btg_prod.rom;name=v560tu \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.1/novacustom_v56x_mtl_igpu_ec_v1.0.1.rom;name=v560tu-ec \
"

SRC_URI = "git://github.com/Dasharo/dts-configs.git;name=dts-configs;protocol=https;branch=develop"
SRCREV = "e5c7262673f14a2962ccdec7718e8f27709523f3"

SRC_URI[v540tu.sha256sum] = "e915ed1eae8b7b91a7a94ad7a75d57a4a077c0e7c6379234755788ca72fb1cd9"
SRC_URI[v540tu-ec.sha256sum] = "9159d4f26cac779d8164abb6e7420a7f08928681b3a5bc5eee835bf6bcc4caad"
SRC_URI[v560tu.sha256sum] = "0c66f864685e5216ff9219c9ff01adf54bb31022742ee19078aa083b065d52c6"
SRC_URI[v560tu-ec.sha256sum] = "9c0da125fe57ec6a1fec616c53d69f8673c6838e7265db6416fdc533e6ea8348"

S = "${WORKDIR}/git"
FILES:${PN} += "/firmware"

# Add BINARIES to SRC_URI with prepended ${FW_STORE_URL}
# nooelint: oelint.task.noanonpython
python() {
    import os
    binaries = d.getVar('BINARIES')
    for binary in binaries.split():
        binary_src_uri = f" ${{FW_STORE_URL}}/{binary}"
        bb.debug(1, f"Appending {binary_src_uri} to SRC_URI")
        d.appendVar('SRC_URI', binary_src_uri)
}

do_install(){
    cd "${WORKDIR}"
    install -d "${D}/firmware"
    stripped_binaries=$(echo "${BINARIES}" | sed 's/;[^ ]*//g')
    for binary in $stripped_binaries; do
        binary_dir=$(dirname "$binary")
        binary_name=$(basename "$binary")
        sha256sum "$binary_name" >"${binary_name}.sha256"
        # not verified during local update
        echo "1" >"${binary_name}.sha256.sig"
        install -Dm 0644 "${binary_name}" "${D}/firmware/$binary_dir/${binary_name}"
        install -Dm 0644 "${binary_name}.sha256" "${D}/firmware/$binary_dir/${binary_name}.sha256"
        install -Dm 0644 "${binary_name}.sha256.sig" "${D}/firmware/$binary_dir/${binary_name}.sha256.sig"
    done
    tar czvf "${D}/firmware/dts-configs.tar.gz" -C "$(dirname "${S}")" "$(basename "${S}")"
}

INHIBIT_DEFAULT_DEPS = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
