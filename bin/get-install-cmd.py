#! /usr/bin/env python

import sys

if __name__ == "__main__":
    recipe_fs = sys.argv[1]
    recipe_reader = open(recipe_fs)

    print "mkdir -p senv log"
    print "conda create -y -p cenv"

    for line in recipe_reader:
        if line.startswith("#") or line.startswith("_") or line.startswith("Loading channels"):
            continue
        tool, version, build = line.split()[:3]
        print "{{ time singularity pull senv/{0}_{1}.simg docker://quay.io/biocontainers/{0}:{1}--{2}; }} 2> log/{0}_singularity.txt".format(tool, version, build)
        print "rm senv/{0}_{1}.simg".format(tool, version)
	print "{{ time conda install -y -p cenv -c bioconda {0}={1}; }} 2> log/{0}_conda.txt".format(tool, version)
        print "conda uninstall -p cenv -y {0}={1}".format(tool, version)
    print "rm -rf senv cenv"
