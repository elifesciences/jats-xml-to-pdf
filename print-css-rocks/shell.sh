#!/bin/bash
set -eu
sudo docker run -it --rm --volume $(pwd)/mnt:/mnt lsh/print-css-rocks-examples /bin/bash
