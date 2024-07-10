PACKAGECONFIG += "systemd-sshd-service-mode"
SYSTEMD_AUTO_ENABLE:${PN}-sshd = "disable"

do_install:append() {
    # replace /usr/libexec/sftp-server with internal-sftp.
    sed -i -r -e "s|^(Subsystem[[:space:]]*sftp[[:space:]]*)/usr/libexec/sftp-server|\1internal-sftp|" ${D}${sysconfdir}/ssh/sshd_config
}
