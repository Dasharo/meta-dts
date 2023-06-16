FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# some services (like the ntpd/crhonyd) log to the /var/log/messages
# we want to keep all logs in the systemd journald
SRC_URI:remove = " file://syslog.cfg"
SRC_URI:append = " file://disable-klogd.cfg"
SRC_URI:append = " file://disable-syslogd.cfg"

SRC_URI:append = " file://enable-devmem.cfg"
