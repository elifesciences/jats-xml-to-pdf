#!/bin/bash
set -eu
sudo docker run -it --rm --volume $(pwd)/mnt:/mnt lsh/pandoc /bin/bash
