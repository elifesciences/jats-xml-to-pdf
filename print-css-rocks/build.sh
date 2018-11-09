#!/bin/bash
set -eux
sudo docker build -t lsh/print-css-rocks-examples . "$@"
