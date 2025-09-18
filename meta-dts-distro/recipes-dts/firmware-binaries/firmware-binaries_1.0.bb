SUMMARY = "Local firmware binaries"
HOMEPAGE = "https://dl.3mdeb.com"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FW_STORE_URL ?= "https://dl.3mdeb.com/open-source-firmware/Dasharo"
BINARIES = " \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.0/novacustom_v54x_mtl_igpu_v1.0.0_btg_provisioned.rom;name=v540tu \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.0/novacustom_v54x_mtl_igpu_v1.0.0_btg_provisioned.rom.sha256;name=v540tu-sha \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.0/novacustom_v54x_mtl_igpu_v1.0.0_btg_provisioned.rom.sha256.sig;name=v540tu-sha-sig \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.0/novacustom_v54x_mtl_igpu_ec_v1.0.0.rom;name=v540tu-ec \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.0/novacustom_v54x_mtl_igpu_ec_v1.0.0.rom.sha256;name=v540tu-ec-sha \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v540tu_mtl/uefi/v1.0.0/novacustom_v54x_mtl_igpu_ec_v1.0.0.rom.sha256.sig;name=v540tu-ec-sha-sig \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.0/novacustom_v56x_mtl_igpu_v1.0.0_btg_provisioned.rom;name=v560tu \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.0/novacustom_v56x_mtl_igpu_v1.0.0_btg_provisioned.rom.sha256;name=v560tu-sha \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.0/novacustom_v56x_mtl_igpu_v1.0.0_btg_provisioned.rom.sha256.sig;name=v560tu-sha-sig \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.0/novacustom_v56x_mtl_igpu_ec_v1.0.0.rom;name=v560tu-ec \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.0/novacustom_v56x_mtl_igpu_ec_v1.0.0.rom.sha256;name=v560tu-ec-sha \
    novacustom_v5x0_mtl/novacustom_mtl_igpu/novacustom_v560tu_mtl/uefi/v1.0.0/novacustom_v56x_mtl_igpu_ec_v1.0.0.rom.sha256.sig;name=v560tu-ec-sha-sig \
"

DEPENDS = "tar"

SRC_URI = "git://github.com/Dasharo/dts-configs.git;name=dts-configs;protocol=https;branch=develop"
SRCREV = "d4fe961c6caa7b1a38ab6489180b8ba7ea331031"

SRC_URI[v540tu.sha256sum] = "d18c4677cf488f69e9caa33a307a4f580eea14b4addb27a2857b2669327708c9"
SRC_URI[v540tu-sha.sha256sum] = "34f4ec1f4cc81c41f4b5bbcda97651b9f5a0394e616a399118fc1a337fb4c480"
SRC_URI[v540tu-sha-sig.sha256sum] = "baebc234f4e89803447068492712978463f5ba019ff11a66a9de84cec170ad96"
SRC_URI[v540tu-ec.sha256sum] = "6b86617e25510a2289f29d1146e2c1d4f5875f21755e910877e07b27ce0a6b8a"
SRC_URI[v540tu-ec-sha.sha256sum] = "0c30d0aea622ae551cfefaba2778ffc2a7cc88389ac0a7ce4f9de3e0da147609"
SRC_URI[v540tu-ec-sha-sig.sha256sum] = "f0418bb0bd2a161813cb38072bae5057b7b781562add45627a4158f575963a09"
SRC_URI[v560tu.sha256sum] = "22c644a19d7f883bcf19ca42943c62afe81b2ead697ae883d89200ff5bf23fc0"
SRC_URI[v560tu-sha.sha256sum] = "57b3fedc9367bc89189dde5a105eca9c282dfb10c4295821c59be0b7fbafd736"
SRC_URI[v560tu-sha-sig.sha256sum] = "581747d46347bfc90f0056b09d9525857f41c36607b89d09dd44b0ea7e129835"
SRC_URI[v560tu-ec.sha256sum] = "4f5a2c3a9023b47a9a4e39b539d34689419c48e31abaa310db7db330c4999eb4"
SRC_URI[v560tu-ec-sha.sha256sum] = "fc3885764248f9627b2157f48b4ad6077b9e96545189f88d109afc54f3db91cf"
SRC_URI[v560tu-ec-sha-sig.sha256sum] = "254a2833822ae22f6b8d65d18874dfb8ec37e0cd0a64bf95e192acaad8ad3aff"

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
    install -d "${D}/firmware"
    stripped_binaries=$(echo "${BINARIES}" | sed 's/;[^ ]*//g')
    for binary in $stripped_binaries; do
        binary_dir=$(dirname "$binary")
        binary_name=$(basename "$binary")
        install -Dm 0644 "${WORKDIR}/$binary_name" "${D}/firmware/$binary_dir/$binary_name"
    done
    tar czvf "${D}/firmware/dts-configs.tar.gz" -C "$(dirname "${S}")" "$(basename "${S}")"
}

INHIBIT_DEFAULT_DEPS = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
