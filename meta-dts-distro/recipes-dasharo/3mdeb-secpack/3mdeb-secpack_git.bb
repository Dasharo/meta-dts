SUMMARY = "A 3mdeb keyring used to verify releases created at 3mdeb"
DESCRIPTION = "Provides a trusted keyring of keys that can be used to verify \
signatures."
HOMEPAGE = "https://github.com/3mdeb/3mdeb-secpack/"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

DEPENDS = "gnupg"

SRC_URI = " \
    git://github.com/3mdeb/3mdeb-secpack.git;protocol=https;branch=master \
"
SRCREV = "70e533e641ed6fbff2a152d7226e8ffe01b68550"
S = "${WORKDIR}/git"

DASHARO_KEYS_HOMEDIR = "${WORKDIR}/dasharo_keys"

do_compile[noexec] = "1"

do_prepare_keyring() {
    mkdir -p '${DASHARO_KEYS_HOMEDIR}'
    gpg --no-default-keyring --keyring pubring.kbx --homedir '${DASHARO_KEYS_HOMEDIR}' --import '${S}/keys/master-key/3mdeb-master-key.asc'
    gpg --no-default-keyring --keyring pubring.kbx --homedir '${DASHARO_KEYS_HOMEDIR}' --import '${S}/dasharo/3mdeb-dasharo-master-key.asc'
    echo "1B5785C2965D84CF85D1652B4AFD81D97BD37C54:6:" | gpg --no-default-keyring --keyring pubring.kbx --homedir '${DASHARO_KEYS_HOMEDIR}' --import-ownertrust
    echo "0D5F6F1DA800329EB7C597A2ABE1D0BC66278008:6:" | gpg --no-default-keyring --keyring pubring.kbx --homedir '${DASHARO_KEYS_HOMEDIR}' --import-ownertrust
}

do_install() {
    install -d 0700 ${D}/${ROOT_HOME}/.dasharo-gnupg
    install -m 0644 ${DASHARO_KEYS_HOMEDIR}/pubring.kbx ${D}/${ROOT_HOME}/.dasharo-gnupg/
    install -m 0600 ${DASHARO_KEYS_HOMEDIR}/trustdb.gpg ${D}/${ROOT_HOME}/.dasharo-gnupg/
}

addtask prepare_keyring after do_compile before do_install

FILES:${PN} = " \
    ${ROOT_HOME} \
"
