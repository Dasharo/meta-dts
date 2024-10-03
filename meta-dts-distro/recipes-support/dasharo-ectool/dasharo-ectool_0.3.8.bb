inherit cargo
inherit pkgconfig

SUMMARY = "Dasharo Open Source Embedded Controller utility"
HOMEPAGE = "https://github.com/Dasharo/ec"

LICENSE = "MIT"
LIC_FILES_CHKSUM = " \
    file://tool/LICENSE;md5=af209eac18ec76ed06fb2839a906b1ad \
"

DEPENDS += "hidapi"
PV:append = ".AUTOINC+${@d.getVar('SRCREV')[:10]}"
SRC_URI = "gitsm://github.com/Dasharo/ec.git;protocol=https;nobranch=1"

CARGO_SRC_DIR = "/tool/"

SRC_URI:append = " \
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

SRCREV = "12d626f3ea1fc16c2ad89d2ec0e560121111d5a4"

SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
SRC_URI[clap-3.2.23.sha256sum] = "71655c45cb9845d3270c9d6df84ebe72b4dad3c2ba3f7023ad47c144e4e473a5"
SRC_URI[clap_lex-0.2.4.sha256sum] = "2850f2f5a82cbf437dd5af4d49848fbdfc27c157c3d010345776f952765261c5"
SRC_URI[downcast-rs-1.2.0.sha256sum] = "9ea835d29036a4087793836fa931b08837ad5e957da9e23886b29586fb9b6650"
SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
SRC_URI[hermit-abi-0.1.19.sha256sum] = "62b467343b94ba476dcb2500d242dadbb39557df889310ac77c5d99100aaac33"
SRC_URI[hidapi-1.5.0.sha256sum] = "798154e4b6570af74899d71155fb0072d5b17e6aa12f39c8ef22c60fb8ec99e7"
SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
SRC_URI[libc-0.2.139.sha256sum] = "201de327520df007757c1f0adce6e827fe8562fbc28bfd9c15571c66ca1f5f79"
SRC_URI[os_str_bytes-6.4.1.sha256sum] = "9b7820b9daea5457c9f21c69448905d723fbd21136ccf521748f23fd49e723ee"
SRC_URI[pkg-config-0.3.26.sha256sum] = "6ac9a59f73473f1b8d852421e59e64809f025994837ef743615c6d0c5b305160"
SRC_URI[redox_hwio-0.1.6.sha256sum] = "8eb516ad341a84372b5b15a5a35cf136ba901a639c8536f521b108253d7fce74"
SRC_URI[strsim-0.10.0.sha256sum] = "73473c0e59e6d5812c5dfe2a064a6444949f089e20eec9a2e5506596494e4623"
SRC_URI[termcolor-1.2.0.sha256sum] = "be55cf8942feac5c765c2c993422806843c9a9a45d4d5c407ad6dd2ea95eb9b6"
SRC_URI[textwrap-0.16.0.sha256sum] = "222a222a5bfe1bba4a77b45ec488a741b3cb8872e5e499451fd7d0129c9c7c3d"
SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"

S = "${WORKDIR}/git"
