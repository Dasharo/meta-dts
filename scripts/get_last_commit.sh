#!/bin/bash

while getopts "r:b:" arg; do
    case $arg in
        r)
            repo="${OPTARG}"
            ;;
        b)
            branch="${OPTARG}"
            ;;
        *)
          exit 1
          ;;
    esac
done

die() {
    echo "$@"
    exit 1
}

[ -n "${repo}" ] || die repo not set
[ -n "${branch}" ] || die branch not set

output=$(git ls-remote --heads "https://github.com/${repo}" "refs/heads/${branch}")
[ "$?" -eq 0 ] || die failed to get commit info

output=$(echo $output | grep -E "^[0-9a-z]+\s+refs/heads/${branch}$")
[ "$?" -eq 0 ] || die failed to parse git output

echo $output | awk '{ print $1 }'
