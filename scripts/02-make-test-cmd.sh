#! /bin/bash -e

conda search -c bioconda > bioconda-recipes.txt
python bin/get-newest.py bioconda-recipes.txt > bioconda-recipes_latest.txt
python bin/get-install-cmd.py bioconda-recipes_latest.txt > bioconda-install.sh

