#!/bin/bash

print_usage() {
  cat <<EOF
Usage: $(basename "$0") [GITHUB_TOKEN]

  Update CHANGELOG.md so it contains all changes between previous release up to
  current commit.
  If you encounter API request limit errors when generating changelog you can
  pass optional GITHUB_TOKEN argument containing your GitHub token which will
  increase those limits.
EOF
}

if [ $# -gt 1 ]; then
  print_usage
  exit 1
fi

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  print_usage
  exit 0
fi

REPO_DIR=$(git rev-parse --show-toplevel)
RELEASE=v$(grep '^DISTRO_VERSION ' "$REPO_DIR/meta-dts-distro/conf/distro/dts-distro.conf" | cut -d'=' -f2 | tr -d ' "')

if [ $# -eq 1 ]; then
  docker run -t --rm -v "$REPO_DIR":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --unreleased --tag "$RELEASE" --github-token "$1"
else
  docker run -t --rm -v "$REPO_DIR":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --unreleased --tag "$RELEASE"
fi
