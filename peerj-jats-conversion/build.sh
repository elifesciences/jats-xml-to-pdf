#!/bin/bash
set -eux
sudo docker build -t lsh/peerj-jats-conversion . "$@"
