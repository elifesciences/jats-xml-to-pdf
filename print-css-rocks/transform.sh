#!/bin/bash
set -e

examples=( lesson-basic lesson-blank-pages lesson-box-styling lesson-chapter-numbering lesson-chart-js 
lesson-complex-css lesson-cmyk lesson-mathml-torture-test )

cd /root/print-css-rocks/

#for dirname in "${examples[@]}"; do
for lesson in ./lesson-*; do
    (
        cd "$lesson/"
        printf "$lesson ..."

        # convert HTML->PDF
        wkhtmltopdf \
            --print-media-type \
            index.html "/mnt/$lesson.pdf" &> /dev/null || {
                echo "failed"
                continue
            }
            echo "success"
    )
done
