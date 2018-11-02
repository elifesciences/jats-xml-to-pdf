#!/bin/bash
set -ex
input="$1" # "in.pdf" no leading path
output="$2" # "out.pdf" no leading path
output_name="${output%.*}" # "out"

cp -R ./dtd/* /mnt/

stylesheet="./jats-conversion-master/src/data/xsl/jats-to-html.xsl"
java -jar /usr/share/java/saxon9he.jar -s:"/mnt/$input" -xsl:$stylesheet -o:"/mnt/$output_name.html"

# convert HTML->PDF
wkhtmltopdf \
    --enable-external-links \
    --no-stop-slow-scripts \
    -L 0 -R 0 -B 0 -T 0 \
    "/mnt/$output_name.html" "/mnt/$output_name.pdf"

