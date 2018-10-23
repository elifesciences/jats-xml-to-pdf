#!/bin/bash
set -eux
sudo docker run -it --rm --volume $(pwd)/mnt:/mnt lsh/jats-xslt /bin/bash
