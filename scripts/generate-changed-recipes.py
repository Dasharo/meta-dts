#!/usr/bin/env python

from pathlib import Path
import os
import sys


def main():
    if len(sys.argv) != 3:
        print(f"Usage: {os.path.basename(__file__)} manifest_old manifest_new")
        return sys.exit(1)

    manifest_old: dict[str, str] = {
        line.split()[0]: line.split()[2]
        for line in Path(sys.argv[1]).read_text().splitlines()
    }
    manifest_new: dict[str, str] = {
        line.split()[0]: line.split()[2]
        for line in Path(sys.argv[2]).read_text().splitlines()
    }

    changed_recipes = [
        recipe for recipe in manifest_old.keys() & manifest_new.keys()
        if manifest_old[recipe] != manifest_new[recipe]
    ]
    new_recipes = manifest_new.keys() - manifest_old.keys()
    deleted_recipes = manifest_old.keys() - manifest_new.keys()

    print("Changed recipes:")
    for changed_recipe in changed_recipes:
        print(f"{changed_recipe}: {manifest_old[changed_recipe]} -> {manifest_new[changed_recipe]}")

    print("New recipes:")
    for new_recipe in new_recipes:
        print(f"{new_recipe}: {manifest_new[new_recipe]}")

    print("Deleted recipes:")
    for deleted_recipe in deleted_recipes:
        print(f"{deleted_recipe}: {manifest_old[deleted_recipe]}")


if __name__ == "__main__":
    main()
