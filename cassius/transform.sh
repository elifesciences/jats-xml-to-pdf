#!/bin/bash
set -e
input="$1"
output="$2" # "out.pdf"
output_name="${output%.*}" # "out"

echo "got $input $output"

cp "/mnt/$input" "/root/dtd/$input"

python ./CaSSius/cassius-import/bin/cassius-import.py "/root/dtd/$input" "/mnt/$output_name.html"

wkhtmltopdf --javascript-delay 15000 --no-stop-slow-scripts -L 0 -R 0 -B 0 -T 0 "/mnt/$output_name.html" "/mnt/$output_name.pdf"
