#!/bin/bash
set -eu

article_list=( 09560 12059 19285 20317 31543 )
(
    cd articles
    for article in "${article_list[@]}"; do
        ./download-article.sh "$article"
    done

    ./download-kitchen-sink.sh
)
