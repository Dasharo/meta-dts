#!/bin/bash

RELEASE=$(grep '^DISTRO_VERSION ' conf/distro/rte.conf | cut -d'=' -f2 | tr -d ' "')

docker run -t -v "$(pwd)":/app/ "orhunp/git-cliff:${TAG:-latest}" \
  --prepend CHANGELOG.md --unreleased --tag "$RELEASE"
