#!/bin/bash
set -e
input="$1"
output="$2" # "out.pdf"
output_name="${output%.*}" # "out"

# to compare to input xml
# pandoc -f jats "/mnt/$input" -t jats -o "/mnt/$output_name.xml"

# this is the intermediate tex file before becoming PDF
# the -s or --standalone flag is necessary else it strips header and title information?
pandoc -f jats "/mnt/$input" -s -o "/mnt/$output_name-intermediate.tex" -t latex

# xml -> pdf using custom intermediate template
# errors in some cases
pandoc \
    -f jats "/mnt/$input" \
    -o "/mnt/$output_name.pdf" \
    --template=/root/latex-template.tex \
    --pdf-engine=xelatex || {

        # TODO: scrap this in favour of using the standalone intermediate directly
        echo "direct jats->pdf failed, attempting jats->latex->pdf"
        # xml -> latex -> pdf
        # succeeds when direct xml -> pdf doesnt
        # this is *more* lossy
        pandoc -f jats "/mnt/$input" -o "/mnt/$output_name.latex"
        pandoc -f latex "/mnt/$output_name.latex" -o "/mnt/$output_name.pdf" --pdf-engine=xelatex
}
