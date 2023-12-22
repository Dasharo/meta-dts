inherit cargo
inherit pkgconfig

SRC_URI += "gitsm://github.com/Dasharo/ec.git;protocol=https;nobranch=1"
SRCREV = "2b2c17ac6e61f45e0fc1bcf6b907a8289f37bcc4"
S = "${WORKDIR}/git"
CARGO_SRC_DIR = "/tool/"
PV:append = ".AUTOINC+411fab9b7c"

SRC_URI += " \
    crate://crates.io/atty/0.2.14 \
    crate://crates.io/autocfg/1.1.0 \
    crate://crates.io/bitflags/1.3.2 \
    crate://crates.io/cc/1.0.79 \
    crate://crates.io/clap/3.2.23 \
    crate://crates.io/clap_lex/0.2.4 \
    crate://crates.io/downcast-rs/1.2.0 \
    crate://crates.io/hashbrown/0.12.3 \
    crate://crates.io/hermit-abi/0.1.19 \
    crate://crates.io/hidapi/1.5.0 \
    crate://crates.io/indexmap/1.9.2 \
    crate://crates.io/libc/0.2.139 \
    crate://crates.io/os_str_bytes/6.4.1 \
    crate://crates.io/pkg-config/0.3.26 \
    crate://crates.io/redox_hwio/0.1.6 \
    crate://crates.io/strsim/0.10.0 \
    crate://crates.io/termcolor/1.2.0 \
    crate://crates.io/textwrap/0.16.0 \
    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
    crate://crates.io/winapi-util/0.1.5 \
    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
    crate://crates.io/winapi/0.3.9 \
"

DEPENDS += "hidapi"
LIC_FILES_CHKSUM = " \
    file://tool/LICENSE;md5=af209eac18ec76ed06fb2839a906b1ad \
"
SUMMARY = "Dasharo EC tool"
HOMEPAGE = "https://github.com/Dasharo/ec"
LICENSE = "MIT"
