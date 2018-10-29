#!/bin/bash
set -e
input="$1"
output="$2"

# xml -> latex -> pdf
# succeeds when direct xml -> pdf doesnt
pandoc -f jats "/mnt/$input" -o "/mnt/$output.latex"
pandoc -f latex "/mnt/$output.latex" -o "/mnt/$output" --pdf-engine=xelatex

# xml -> pdf
# errors in some cases
#pandoc -f jats "/mnt/$input" -o "/mnt/$output" --pdf-engine=xelatex
