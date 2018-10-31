#!/bin/bash
# downloads an article from the (public) elife article repository
set -eu

msid="$1"

printf "$msid... "

if [ ! -d venv ]; then
    python -m venv venv
    source venv/bin/activate
    pip install awscli
fi

source venv/bin/activate
    
if [ ! -d "$msid" ]; then
    printf "downloading... "
    aws s3 cp --quiet --recursive "s3://prod-elife-published/articles/$msid/" "$msid"
fi

zipfile="$msid.tar.gz"
if [ ! -f $zipfile ]; then
    printf "zipping ... "
    tar -czf "$zipfile" "$msid/"
fi

echo "done"
