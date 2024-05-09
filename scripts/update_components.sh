#!/bin/bash

SCRIPTDIR=$(readlink -f $(dirname "$0"))
ROOT=$(readlink -f "${SCRIPTDIR}/..")
GET_LAST_COMMIT="${SCRIPTDIR}/get_last_commit.sh"
CHANGELOG_FILE="$ROOT/CHANGELOG.md"
CHANGELOG_TMP_FILE="$ROOT/CHANGELOG-tmp.md"

die() {
    echo "$@"
    exit 1
}

(
cd "${ROOT}"

#
# Determine DTS release version
#
DTS_VER=v`cat meta-dts-distro/conf/distro/dts-distro.conf | grep DISTRO_VERSION | tr -d "\" [A-Z]_="`

#
# Arguments
#   1 - path to recipe
#

get_srcrev() {
    local recipe_path="$1"

    if [ ! -f "${recipe_path}" ]; then
        die "${recipe_path} does not exist"
    fi

    _retval=$(grep -E "SRCREV\s*=\s*[\"']([a-zA-Z0-9]*)[\"']" "${recipe_path}" \
        | sed -E "s/SRCREV\s*=\s*[\"']([a-zA-Z0-9]*)[\"']/\1/"
    )
}

#
# Arguments
#  1 - path to recipe to update
#  2 - srcrev to set
#
do_update_srcrev() {
    local recipe_path="$1"
    local new_srcrev="$2"

    if [ ! -f "${recipe_path}" ]; then
        die "${recipe_path} does not exist"
    fi

    sed -Ei "s/SRCREV\s*=\s*[\"']([a-zA-Z0-9]*)[\"']/SRCREV = \"${new_srcrev}\"/g" "${recipe_path}"
}

update_failed() {
    echo "Failed to update \"$2\": $1"
    echo "  repo: $4"
    echo "  branch: $5"
    die
}

# Determine last commit ID, update recipes and make commits
#
# Arguments
# 1 - component name
# 2 - path to recipe to update
# 3 - repository name
# 4 - branch
do_update() {
    local component_name="$1"
    local recipe_path="$2"
    local repository="$3"
    local branch="$4"

    last_commit=$($GET_LAST_COMMIT -r $repository -b $branch)
    [ "$?" -eq 0 ] || update_failed "failed to obtain last commit info: ${last_commit}" "$@"

    get_srcrev $recipe_path
    old_commit="${_retval}"

    if [ "${old_commit}" == "${last_commit}" ]; then
        echo "${component_name} is up to date"
    else
        echo "Updating $1 to $last_commit"
        do_update_srcrev "${recipe_path}" "${last_commit}"

        # update changelog, determine which line to modify, it should be X-2
        # where X is header of one after latest release, as we want to add new
        # changelog info at the end of latest release
        line_number=$(grep -n '##' CHANGELOG.md | sed -n '2p' | cut -d ":" -f 1)
        result=$((line_number - 2))

        sed ""$result"a\* Updated $1 to revision $last_commit" $CHANGELOG_FILE > $CHANGELOG_TMP_FILE
        cp $CHANGELOG_TMP_FILE $CHANGELOG_FILE
        git add "${recipe_path}"
        git commit -F - <<< "${component_name}: update to ${last_commit}"
    fi
}

do_update "dasharo-configuration-utility" \
    "meta-dts-distro/recipes-dasharo/dasharo-configuration-utility/dasharo-configuration-utility_git.bb" \
    "Dasharo/dcu" \
    "main"

do_update "flashrom" \
    "meta-dts-distro/recipes-bsp/flashrom/flashrom_git.bb" \
    "Dasharo/flashrom" \
    "dasharo-release"

do_update "ec" \
    "meta-dts-distro/recipes-support/dasharo-ectool/dasharo-ectool_0.3.8.bb" \
    "Dasharo/ec" \
    "master"

do_update "fwupd" \
    "meta-dts-distro/recipes-bsp/fwupd/fwupd_2.0.1.bb" \
    "Dasharo/fwupd" \
    "dasharo-release"

do_update "coreboot-utils" \
    "meta-dts-distro/recipes-bsp/coreboot-utils/coreboot-utils.inc" \
    "Dasharo/coreboot" \
    "dasharo"

do_update "3mdeb-secpack" \
    "meta-dts-distro/recipes-dasharo/3mdeb-secpack/3mdeb-secpack_git.bb" \
    "3mdeb/3mdeb-secpack" \
    "master"

if [ -f "$CHANGELOG_TMP_FILE" ]; then
    rm -rf $CHANGELOG_TMP_FILE
    git add $CHANGELOG_FILE
    git commit -F - <<< "CHANGELOG.md: fill up after automatic update of components"
fi

git commit -F - <<< "Release ${DTS_VER}"
git push --set-upstream origin "main"
# update tag position, should not trigger new pipeline
git tag "${DTS_VER}"
git push --set-upstream origin "${DTS_VER}"
)
