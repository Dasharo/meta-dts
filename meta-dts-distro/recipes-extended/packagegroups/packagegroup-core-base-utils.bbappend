# we are using systemd-networkd to get IP address, avoid getting two
# addresses
RDEPENDS:${PN}:remove = "dhcpcd"
