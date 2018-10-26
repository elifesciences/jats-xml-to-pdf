#!/bin/bash
set -eu
infile="$1"
infile_fname=$(basename $infile)
outfile="$2"
outfile_fname=$(basename $outfile)

mkdir -p ./mnt/
cp "$infile" "./mnt/$infile_fname"
sudo docker run \
    -it \
    --rm \
    --volume $(pwd)/mnt:/mnt \
    lsh/cassius \
    ./transform.sh "$infile_fname" "$outfile_fname"
sudo chown 1000:1000 -R ./mnt/

if [ -e "./mnt/$outfile_fname" ]; then
    mv "./mnt/$outfile_fname" "$outfile"
else
    echo "failed to generate $outfile"
fi
