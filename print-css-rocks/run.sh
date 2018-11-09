#!/bin/bash
set -eux

sudo rm -rf ./mnt

echo "container: start"
sudo docker run \
    -it \
    --rm \
    --volume $(pwd)/mnt:/mnt \
    lsh/print-css-rocks-examples \
    ./transform.sh
echo "container: end"
