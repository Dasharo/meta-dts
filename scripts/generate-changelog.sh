#!/bin/bash

REPO_DIR=$(git rev-parse --show-toplevel)
if [ $# -eq 1 ]; then
  docker run -t -v "$REPO_DIR":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --latest --github-token "$1"
else
  docker run -t -v "$REPO_DIR":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --latest
fi
