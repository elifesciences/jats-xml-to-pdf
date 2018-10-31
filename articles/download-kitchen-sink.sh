#!/bin/bash
# downloads the kitchen sink from github
set -eu

repo="https://github.com/elifesciences/XML-mapping/archive/master.zip"
zipfile="00666.tar.gz"

printf "kitchen sink... "
rm -rf ./00666 ./XML-mapping-master "$zipfile"

if [ ! -f master.zip ]; then
    printf "downloading... "
    wget --quiet "$repo"
fi

unzip master.zip &> /dev/null
mv XML-mapping-master 00666

(
    cd 00666
    rm *.pdf # remove any confusion
    mv elife-00666.xml elife-00666-v1.xml # consistent naming pattern helps
)

printf "zipping... "
tar -czf "$zipfile" "00666/"

echo "done"
