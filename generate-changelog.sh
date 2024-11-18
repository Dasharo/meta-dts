#!/bin/bash

if [ $# -eq 1 ]; then
  docker run -t -v "$(pwd)":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --latest --github-token "$1"
else
  docker run -t -v "$(pwd)":/app/ "orhunp/git-cliff:${TAG:-latest}" \
    --prepend CHANGELOG.md --latest
fi
