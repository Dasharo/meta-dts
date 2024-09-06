require coreboot-utils.inc

SUMMARY = "\
          Converts the configuration DW0/1 registers value from an inteltool \
          dump to coreboot macros.\
          "

LIC_FILES_CHKSUM = "file://../../COPYING;md5=751419260aa954499f7abaabaa882bbe"

GO_IMPORT = "github.com/dasharo/coreboot/"

# we need to override SRC_URI from coreboot-utils.inc so it's unpacked in the
# directory as expected by the go bbclass
SRC_URI = " \
          git://github.com/dasharo/coreboot.git;protocol=https;branch=dasharo-4.21;destsuffix=${GO_IMPORT} \
          "

S = "${WORKDIR}/${GO_IMPORT}/util/intelp2m"

inherit goarch
inherit go

do_compile() {
    export GOARCH="${TARGET_GOARCH}"
    cd ${S}
    go version
    go build -trimpath -v -o intelp2m
}

do_install() {
    install -d ${D}/${sbindir}
    install ${S}/${PN} ${D}/${sbindir}
}
