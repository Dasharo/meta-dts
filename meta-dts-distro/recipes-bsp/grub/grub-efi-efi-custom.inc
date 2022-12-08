FILESEXTRAPATHS:prepend := "${THISDIR}/grub-efi-custom:"

RDEPENDS:${PN}:remove = " virtual-grub-bootconf"

do_deploy:append () {
	install -d ${DEPLOY_DIR_IMAGE}/bootfiles
	cp -r ${D}/boot/* ${DEPLOY_DIR_IMAGE}/bootfiles/
}
