#!/bin/bash
set -eux
sudo docker build -t lsh/jats2latex . "$@"
