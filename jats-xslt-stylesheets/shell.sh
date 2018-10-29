#!/bin/bash
set -eu
sudo docker run -it --rm --volume $(pwd)/mnt:/mnt lsh/jats-xslt-stylesheets /bin/bash
