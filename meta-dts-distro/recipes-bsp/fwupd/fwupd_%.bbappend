PACKAGECONFIG = " \
  curl gnutls gudev gusb \
  ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd offline', '', d)} \
  plugin_flashrom \
  sqlite \
"
