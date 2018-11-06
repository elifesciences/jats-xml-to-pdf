#!/bin/bash
set -e
input="$1"
output="$2" # "out.pdf"
output_name="${output%.*}" # "out"

# this is the intermediate tex file before becoming PDF
# the -s or --standalone flag is necessary else it strips header and title information?
pandoc -f jats "/mnt/$input" --standalone -o "/mnt/$output_name-intermediate.tex" -t latex #--filter ./abstract.sh

# xml -> latex -> pdf, using custom intermediate template
# often succeeds when direct xml->pdf doesnt
pandoc \
    -f latex "/mnt/$output_name-intermediate.tex" \
    -o "/mnt/$output_name.pdf" \
    --pdf-engine=xelatex \
    --template=/root/latex-template.tex || {

        echo "failed, attempting non-standalone conversion"

        # try rendering using a non-standalone template. the output will be incomplese but you'll have *something*
        pandoc -f jats "/mnt/$input" -o "/mnt/$output_name-intermediate2.tex" -t latex #--filter ./abstract.sh
        pandoc \
            -f latex "/mnt/$output_name-intermediate2.tex" \
            -o "/mnt/$output_name.pdf" \
            --pdf-engine=xelatex \
            --template=/root/latex-template.tex
}
