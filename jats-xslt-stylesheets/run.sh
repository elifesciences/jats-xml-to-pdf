#!/bin/bash
set -eu
infile="$1"
infile_fname=$(basename $infile)
outfile="$2"
outfile_fname=$(basename $outfile)

if [ ! -d ./mnt ]; then
    # probably a once-off
    mkdir -p ./mnt/
    cp "$infile" "./mnt/$infile_fname"
fi

sudo docker run \
    -it \
    --rm \
    --volume $(pwd)/mnt:/mnt \
    lsh/jats-xslt-stylesheets \
    ./transform.sh "$infile_fname" "$outfile_fname"

test -e "./mnt/$outfile_fname"
