#!/bin/bash
set -e
input="$1"
output="$2"
echo "got $input and $output"
pandoc -f jats "/mnt/$input" -o "/mnt/$output" --pdf-engine=xelatex
