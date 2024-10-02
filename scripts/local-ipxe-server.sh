#!/bin/bash

SCRIPTDIR=$(readlink -f "$(dirname "$0")")

error_exit() {
    _error_msg="$1"
    echo "$_error_msg"
    exit 1
}

error_check() {
    _error_code=$?
    _error_msg="$1"
    [ "$_error_code" -ne 0 ] && error_exit "$_error_msg : ($_error_code)"
}

cat <<EOF
--------------------------------------------------------------------------------
This script by default sets the server up on port 9000. If you want to use a
different port, for example 9001, then run the script like this:
    ./meta-dts/scripts/ipxe-dts.sh 9001
Do you want to continue? [y/n]
EOF

read -r response
if [ "$response" = "y" ]; then
    echo "Continuing with the script..."
    # Add the rest of your script here
else
    echo "Exiting the script."
    exit 1
fi

userIP=$(ip route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q')
error_check "cannot get user IP"

distroVersion=$(cat "$SCRIPTDIR/../meta-dts-distro/conf/distro/dts-distro.conf" | grep -F "DISTRO_VERSION" | awk -F'"' '{print $2}')
error_check "cannot get distro version from 'meta-dts/meta-dts-distro/conf/distro/dts-distro.conf'"

mkdir -p $SCRIPTDIR/ipxe-files
error_check "cannot make directory 'ipxe-files'"

cd $SCRIPTDIR/ipxe-files
error_check "cannot cd to '$SCRIPTDIR/ipxe-files'"

wget --output-document="bzImage-v$distroVersion" "https://boot.dasharo.com/dts/v$distroVersion/bzImage-v$distroVersion"
error_check "cannot wget the bzImage v$distroVersion from https://boot.dasharo.com/dts/v$distroVersion/bzImage-v$distroVersion"

wget --output-document="dts-base-image-v$distroVersion.cpio.gz" "https://boot.dasharo.com/dts/v$distroVersion/dts-base-image-v$distroVersion.cpio.gz"
error_check "cannot wget the cpio.gz v$distroVersion from https://boot.dasharo.com/dts/v$distroVersion/dts-base-image-v$distroVersion.cpio.gz"

port=${1:-9000}

cat <<EOF >dts.ipxe
#!ipxe
#
kernel http://$userIP:$port/bzImage-v$distroVersion root=/dev/nfs initrd=http://$userIP/dts-base-image-v$distroVersion.cpio.gz
initrd http://$userIP:$port/dts-base-image-v$distroVersion.cpio.gz
module http://$userIP:$port/commands.sh /sbin/ipxe-commands mode=755
boot
EOF
error_check "cannot create 'dts.ipxe' bootchain file"

cp ../commands.sh .
error_check "cannot copy 'commands.sh' script"

cat <<EOF
--------------------------------------------------------------------------------
you can now boot dts v$distroVersion through iPXE on another machine by running:
    dhcp
    chain http://$userIP:$port/dts.ipxe
on that machine in the iPXE shell. It will also execute a simple "commands.sh"
script after booting. If you want to change its contents, just change the
"scripts/commands.sh" file, and rerun this script.

This script by default sets the server up on port 9000. If you want to use a
different port, for example 9001, then run the script like this:
    ./meta-dts/scripts/ipxe-dts.sh 9001
--------------------------------------------------------------------------------
EOF
error_check "cannot print final message"

python3 -m http.server $port
error_check "Failed to create HTTP server with python on port:$port, ip:$userIP."
