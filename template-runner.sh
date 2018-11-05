#!/bin/bash
set -eux
infile="$1"
infile_fname=$(basename $infile)
outfile="$2"
outfile_fname=$(basename $outfile)

if [ -d $infile ]; then
    # a dir has been specified, copy it's contents to /mnt
    # the root run.sh populates the ./mnt dir directly
    sudo rm -rf ./mnt
    cp -R "$infile" ./mnt/
    infile_fname="elife-$infile_fname-v1.xml"
fi

if [ -f "$infile" ] && [ ! "$infile" = "./mnt/$infile_fname" ]; then
    cp "$infile" "./mnt/$infile_fname"
fi

ls -l ./mnt # sanity check for debugging logs

echo "container: start"
sudo docker run \
    -it \
    --rm \
    --volume $(pwd)/mnt:/mnt \
    lsh/CONTAINER_NAME \
    ./transform.sh "$infile_fname" "$outfile_fname"
echo "container: end"

test -e "./mnt/$outfile_fname"
