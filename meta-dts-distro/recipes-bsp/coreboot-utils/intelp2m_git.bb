require coreboot-utils.inc

LIC_FILES_CHKSUM = "file://../../COPYING;md5=751419260aa954499f7abaabaa882bbe"

GO_IMPORT = "github.com/dasharo/coreboot/"

# we need to override SRC_URI from coreboot-utils.inc so it's unpacked in the
# directory as expected by the go bbclass
SRC_URI = " \
    git://github.com/Dasharo/coreboot.git;protocol=https;branch=coreboot-utils;destsuffix=${GO_IMPORT} \
    "

S = "${WORKDIR}/${GO_IMPORT}/util/intelp2m"

inherit goarch
inherit go

do_compile() {
    export GOARCH="${TARGET_GOARCH}"
    export GOPATH="${WORKDIR}/git/"

    export GO111MODULE=off

    cd ${S}

    oe_runmake
}

do_install() {
    install -d ${D}/${sbindir}
    install ${S}/${PN} ${D}/${sbindir}
}
