#!/bin/bash
set -e
input="$1"
output="$2" # "out.pdf"
output_name="${output%.*}" # "out"

# to compare to input xml
# pandoc -f jats "/mnt/$input" -t jats -o "/mnt/$output_name.xml"

# this is the intermediate tex file before becoming PDF
# the -s or --standalone flag is necessary else it strips header and title information?
pandoc -f jats "/mnt/$input" -s -o "/mnt/$output_name-intermediate.tex" -t latex --filter ./abstract.sh

# xml -> latex -> pdf, using custom intermediate template
# often succeeds when direct xml->pdf doesnt
pandoc \
    -f latex "/mnt/$output_name-intermediate.tex" \
    -o "/mnt/$output_name.pdf" \
    --template=/root/latex-template.tex \
    --pdf-engine=xelatex
