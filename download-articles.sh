#!/bin/bash
set -eu

# 09560 -- homo naledi
# -- article is too large. 12059 -- random
# 19258 -- random
# 20317 -- random
# 31543 -- random
# 00569 -- fringe, "Everything!"
# 05378 -- fringe, "Grey rows in Table"
# -- article is too large. 18566 -- fringe, "Appendix with 67 tables and 243 equations"

article_list=( 09560 19285 20317 31543 00569 05378 18566 )
(
    cd articles
    for article in "${article_list[@]}"; do
        ./download-article.sh "$article"
    done

    ./download-kitchen-sink.sh
)
