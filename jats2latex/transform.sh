#!/bin/bash
set -e
input="$1"
output="$2"

cp -R dtd/* /mnt/
java -jar latex.jar /mnt/$input /mnt/article.tex /mnt/article.bib

# ... nothing yet! doesn't get beyond this
echo "woo?"
