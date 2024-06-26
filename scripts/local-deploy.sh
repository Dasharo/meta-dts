#!/usr/bin/env bash

# This scripts deplos DTS scripts into target machine, for local development

IP_ADDR="$1"
PORT=${PORT:-22}

scp -P ${PORT} \
  -O \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/dev/null \
  meta-dts-distro/recipes-dts/dts/dasharo-deploy/* \
  meta-dts-distro/recipes-dts/dts/dts/* \
  meta-dts-distro/recipes-dts/reports/dasharo-hcl-report/* \
  unit_tests/* \
  root@${IP_ADDR}:/usr/sbin
