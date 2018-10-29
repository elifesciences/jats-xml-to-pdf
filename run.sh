#!/bin/bash

set -eu

transformers=( cassius jats-xslt-stylesheets pandoc )

# init everything, build the containers, reset any changes to the ad-hoc scripts, etc
mkdir -p "./pdf"
mkdir -p "./log"

if [ ! -f "built.flag" ]; then
    for tname in "${transformers[@]}"; do
        sudo rm -rf "./$tname/mnt/"
        sed "s/lsh\/CONTAINER_NAME/lsh\/$tname/" template-shell.sh > "./$tname/shell.sh"
        sed "s/lsh\/CONTAINER_NAME/lsh\/$tname/" template-build.sh > "./$tname/build.sh"
        sed "s/lsh\/CONTAINER_NAME/lsh\/$tname/" template-runner.sh > "./$tname/run.sh"
        (
            cd "./$tname"
            ./build.sh
        )
    done
    touch "built.flag"
    exit 0
fi

for zipfile in ./articles/*.tar.gz; do
    fname=$(basename $zipfile) # 09560.tar.gz
    msid="${fname%%.*}" # 09560
    echo "article $msid"
    for tname in "${transformers[@]}"; do
        printf " - $tname ..."

        name="$tname--$msid"
        pdf="$name.pdf" # cassius--09560.pdf
        log="$name.log"
        
        # pdf for this article+transformer exists, skip to next
        if [ -f "./pdf/$pdf" ]; then
            echo "exists"
            continue
        fi

        # remove previous results
        sudo rm -rf "./$tname/mnt" # TODO: 'sudo' usage is a smell
        mkdir "./$tname/mnt"

        # unpack article
        tar -xf $zipfile --directory "./$tname/mnt/" --strip 1
        (
            cd "./$tname"
            
            xml="./elife-$msid-v1.xml"
            echo > "../log/$log" # empty log
            ./run.sh "./mnt/$xml" $pdf >> "../log/$log" 2>&1 || {
                echo "failed $?"
                continue
            }

            if [ ! -e "./mnt/$pdf" ]; then
                echo "pdf missing, exited successfully"
                continue
            fi

            mv "./mnt/$pdf" "../pdf/"
            echo "done"
        )
    done
done

sudo chown 1000:1000 -R ./pdf/
