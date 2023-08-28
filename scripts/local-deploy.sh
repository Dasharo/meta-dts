#!/usr/bin/env bash

# This scripts deplos DTS scripts into target machine, for local development

IP_ADDR="$1"

scp -O dasharo-deploy/* dts/* root@$IP_ADDR:/usr/sbin
