#!/bin/bash
set -eu
sudo docker run -it --rm --volume $(pwd)/mnt:/mnt lsh/CONTAINER_NAME /bin/bash
