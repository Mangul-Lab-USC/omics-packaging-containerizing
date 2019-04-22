#! /usr/bin/env python

import sys

if __name__ == "__main__":
    recipe_fs = sys.argv[1]
    recipe_reader = open(recipe_fs)

    print "mkdir -p senv log"

    for line in recipe_reader:
	# skip commentaries lines
        if line.startswith("#") or line.startswith("_") or line.startswith("Loading channels"):
            continue

        tool, version, build = line.split()[:3]
        print "echo {0}:{1}".format(tool, version)
	print ("{{ time singularity pull " +
	       "senv/{0}_{1}.simg " +
               "docker://quay.io/biocontainers/{0}:{1}--{2}; }} " +
               "2> log/{0}_singularity.txt").format(tool, version, build)
	print "ls -s senv/{0}_{1}.simg >> log/{0}_singularity.txt".format(tool, version)
        print "rm senv/{0}_{1}.simg".format(tool, version)
