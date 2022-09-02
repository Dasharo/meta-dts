inherit cargo

SRC_URI += "gitsm://git@github.com/ruabmbua/hidapi-rs.git;protocol=ssh;nobranch=1"
SRCREV = "f39c5e17a50ada9f8b631dbbc2c4d262553e5602"
S = "${WORKDIR}/git"
CARGO_SRC_DIR = ""
PV:append = ".AUTOINC+f39c5e17a5"

SRC_URI += " \
    crate://crates.io/cc/1.0.73 \
    crate://crates.io/libc/0.2.132 \
    crate://crates.io/pkg-config/0.3.25 \
"

LIC_FILES_CHKSUM = " \
    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420 \
"

SUMMARY = "Rust-y wrapper around hidapi"
HOMEPAGE = "https://github.com/ruabmbua/hidapi-rs"
LICENSE = "MIT"
