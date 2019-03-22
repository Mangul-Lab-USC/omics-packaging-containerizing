#! /usr/bin/env python

import sys

if __name__ == "__main__":
    recipe_fs = sys.argv[1]
    recipe_reader = open(recipe_fs)

    latest_recipe = dict()

    for line in recipe_reader:
        if line.startswith("#") or line.startswith("Loading channels"):
            continue
        name, version, build, _ = line.split()
        latest_recipe[name] = [name, version, build]

    for name in sorted(latest_recipe.iterkeys()):
        print "\t".join(latest_recipe[name])
