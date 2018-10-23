#!/bin/bash
set -eu
infile="$1"
infile_fname=$(basename $infile)
outfile="$2"
cp "$infile" "./mnt/$infile_fname"
sudo docker run \
    -it \
    --rm \
    --volume $(pwd)/mnt:/mnt \
    lsh/jats-xslt \
    ./transform.sh "$infile_fname" "$outfile"
