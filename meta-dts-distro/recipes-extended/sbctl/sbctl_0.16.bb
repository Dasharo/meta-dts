SUMMARY = "Secure Boot key manager"
HOMEPAGE = "https://github.com/foxboron/sbctl.git"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=90982035f2d0342d5bf8ac9dfceefa7a"

GO_IMPORT = "github.com/Foxboron/sbctl"

inherit go-mod

SRC_URI = "git://${GO_IMPORT}.git;protocol=https;branch=master"
SRCREV = "53e074d6934f5ecfffa81a576293219c717f7d19"

RDEPENDS:${PN} = "binutils util-linux-lsblk"
RDEPENDS:${PN}-dev = "bash"

do_compile(){
    go build ${GOBUILDFLAGS} -o ${GOPATH}/bin/sbctl ./cmd/sbctl
    chmod -R +w "${GOMODCACHE}"
}
