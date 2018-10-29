#!/bin/bash
set -eu
infile="$1"
infile_fname=$(basename $infile)
outfile="$2"
outfile_fname=$(basename $outfile)

rm -rf ./mnt
if [ -d $infile ]; then
    # a dir has been specified, copy it's contents to /mnt
    cp -R "$infile" ./mnt/
    infile_fname="elife-$infile_fname-v1.xml"
fi

if [ -f "$infile" ]; then
    cp "$infile" "./mnt/$infile_fname"
fi

sudo docker run \
    -it \
    --rm \
    --volume $(pwd)/mnt:/mnt \
    lsh/pandoc \
    ./transform.sh "$infile_fname" "$outfile_fname"

test -e "./mnt/$outfile_fname"
