#!/bin/bash

set -eu

transformers=( cassius jats-xslt-stylesheets pandoc jats2latex peerj-jats-conversion )

# https://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt
function timer_now {
    date +%s%N
}

function timer_start {
    timer_start=${timer_start:-$(timer_now)}
}

function timer_stop {
    local delta_us=$((($(timer_now) - $timer_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
    else timer_show=${us}us
    fi
    unset timer_start
}

function update_metrics {
    local metric=$1
    local msid=$2
    local tform=$3
    local val=$4
    local success=$5
    
    local fname="$metric.csv" # timing.txt
    touch "$fname"
    echo "$msid,$tform,$val,$success" >> "../$fname"
}


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


echo "msid,transformer,time,success" > timing.csv

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
            
            xml="elife-$msid-v1.xml"
            echo > "../log/$log" # empty log
            timer_start
            ./run.sh "./mnt/$xml" $pdf &> "../log/$log" || {
                timer_stop
                update_metrics "timing" $msid $tname $timer_show "false"
                printf "failed '$?'"
                if [ -f "./mnt/$pdf" ]; then
                    printf " pdf generated"
                    mv "./mnt/$pdf" "../pdf/"
                fi
                echo
                continue
            }
            timer_stop

            if [ ! -e "./mnt/$pdf" ]; then
                update_metrics "timing" $msid $tname $timer_show "false"
                echo "pdf missing but exited successfully"
                continue
            fi

            update_metrics "timing" $msid $tname $timer_show "true"
            mv "./mnt/$pdf" "../pdf/"
            echo "done"
        )
    done
done

sudo chown 1000:1000 -R ./pdf/
