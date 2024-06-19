SUMMARY = "Simple and fasst CLI tool to manage MinIO deployments."
HOMEPAGE = "https://min.io/docs/minio/linux/reference/minio-mc.html"
SECTION = "net"

GO_IMPORT = "github.com/minio/mc"

inherit go-mod

LICENSE = "AGPL-3.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=eb1e647870add0502f8f010b19de32af"

SRC_URI = "git://${GO_IMPORT};protocol=https;branch=master"
SRCREV = "e7c9a733c680fe62066d24e8718f81938b4f6606"

FILES:${PN} += "${bindir}/mc"

# MinIO CLI depends on getent which is a part of glibc-utils.
RDEPENDS:${PN} = "glibc-utils"
# github.com/minio/mc has some Bash scripts.
RDEPENDS:${PN}-dev = "bash"
