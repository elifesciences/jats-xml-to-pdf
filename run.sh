#!/bin/bash

set -ex

transformers=( jats2latex cassius jats-xslt-stylesheets pandoc )

mkdir -p "./pdf"

for zipfile in ./articles/*; do
    fname=$(basename $zipfile) # 09560.zip
    fname="${fname%.*}" # 09560
    for tname in "${transformers[@]}"; do
        rm -rf "./$tname/mnt" # remove results of previous files
        unzip $zipfile -d "./$tname/mnt/"
        pdf="$tname--$fname.pdf" # cassius--09560.pdf
        ./$tname/run.sh $xml $pdf
    done
done
