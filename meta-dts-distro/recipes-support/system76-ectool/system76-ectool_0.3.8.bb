inherit cargo
inherit pkgconfig

SRC_URI += "gitsm://github.com/system76/ec.git;protocol=https;nobranch=1"
SRCREV = "a8213311b19c30f7ba0a9673664d4bebc7ed64f1"
S = "${WORKDIR}/git"
CARGO_SRC_DIR = "/tool/"
PV:append = ".AUTOINC+a8213311b1"

SRC_URI += " \
    crate://crates.io/ansi_term/0.12.1 \
    crate://crates.io/atty/0.2.14 \
    crate://crates.io/bitflags/1.3.2 \
    crate://crates.io/cc/1.0.73 \
    crate://crates.io/clap/2.34.0 \
    crate://crates.io/downcast-rs/1.2.0 \
    crate://crates.io/hermit-abi/0.1.19 \
    crate://crates.io/hidapi/1.3.4 \
    crate://crates.io/libc/0.2.121 \
    crate://crates.io/pkg-config/0.3.25 \
    crate://crates.io/redox_hwio/0.1.5 \
    crate://crates.io/strsim/0.8.0 \
    crate://crates.io/textwrap/0.11.0 \
    crate://crates.io/unicode-width/0.1.9 \
    crate://crates.io/vec_map/0.8.2 \
    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
    crate://crates.io/winapi/0.3.9 \
    crate://crates.io/system76_ectool/0.3.8 \
"
DEPENDS += "hidapi"
LIC_FILES_CHKSUM = " \
    file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464 \
"
SUMMARY = "System76 EC tool"
HOMEPAGE = "https://github.com/system76/ec"
LICENSE = "GPL-3.0-only"
