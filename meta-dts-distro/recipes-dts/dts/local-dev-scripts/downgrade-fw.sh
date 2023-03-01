#!/usr/bin/env bash

# This scripts downgrades FW on NV4X TGL machine to 1.3.0 for testing purposes

IP_ADDR="$1"

ssh root@$IP_ADDR wget -O /tmp/bios.rom https://3mdeb.com/open-source-firmware/Dasharo/novacustom_nv4x/v1.3.0/novacustom_nv4x_v1.3.0.rom
ssh root@$IP_ADDR wget -O /tmp/ec.rom https://3mdeb.com/open-source-firmware/Dasharo/novacustom_nv4x/v1.3.0/novacustom_nv4x_ec_v1.3.0.rom
ssh root@$IP_ADDR flashrom -p internal -w /tmp/bios.rom --fmap -i RW_SECTION_A
ssh root@$IP_ADDR system76_ectool flash /tmp/ec.rom
