#!/bin/bash
# downloads the kitchen sink from github
set -eu

repo="https://github.com/elifesciences/XML-mapping/archive/master.zip"
zipfile="00666.tar.gz"

rm -rf ./00666 ./XML-mapping-master master.zip "$zipfile"

wget --quiet "$repo"
unzip master.zip &> /dev/null
rm master.zip
mv XML-mapping-master 00666

(
    cd 00666
    rm *.pdf # remove any confusion
    mv elife-00666.xml elife-00666-v1.xml # consistent naming pattern helps
)
tar -czf "$zipfile" "./00666/"
