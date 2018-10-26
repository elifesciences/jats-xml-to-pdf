#!/bin/bash

set -ex

transformers=( jats2latex cassius jats-xslt-stylesheets pandoc )

mkdir -p "./pdf"

for path in ./articles/*; do
    fname=$(basename $path)
    xml="./articles/$fname/elife-$fname-v1.xml"
    for tname in "${transformers[@]}"; do
        pdf="./pdf/$tname/$fname.pdf"
        ./$tname/run.sh $xml $pdf
    done
done
