#!/bin/bash
set -eux
sudo docker run -it --rm --volume $(pwd)/mnt:/mnt lsh/pandoc /bin/bash
