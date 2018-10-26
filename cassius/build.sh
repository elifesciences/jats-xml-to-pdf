#!/bin/bash
set -e
mkdir -p mnt/
sudo docker build -t lsh/cassius . "$@"
