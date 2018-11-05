#!/bin/bash
set -ex
input="$1"
output="$2" # "out.pdf"
output_name="${output%.*}" # "out"

cp "/mnt/$input" "/root/dtd/$input"

# convert XML->HTML
python ./CaSSius/cassius-import/bin/cassius-import.py "/root/dtd/$input" "/mnt/$output_name.html"

# paths in the html reference the cassius dir
cp -R /root/CaSSius/cassius /mnt/

# convert HTML->PDF
wkhtmltopdf \
    --print-media-type \
    --javascript-delay 15000  \
    --enable-external-links \
    --no-stop-slow-scripts \
    -L 0 -R 0 -B 0 -T 0 \
    "/mnt/$output_name.html" "/mnt/$output_name.pdf"
