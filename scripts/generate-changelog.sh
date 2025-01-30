#!/bin/bash

REPO_DIR=$(git rev-parse --show-toplevel)
RELEASE=v$(grep '^DISTRO_VERSION ' "$REPO_DIR/meta-dts-distro/conf/distro/dts-distro.conf" | cut -d'=' -f2 | tr -d ' "')

if [ $# -eq 1 ]; then
  docker run -t -v "$REPO_DIR":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --unreleased --tag "$RELEASE" --github-token "$1"
else
  docker run -t -v "$REPO_DIR":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --unreleased --tag "$RELEASE"
fi
