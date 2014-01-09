#!/usr/bin/env bash
set -v
# 
function packagesToInstall() {
    sort $1 > .$1.sorted
    sort $2 > .$2.sorted
    diff=`diff --unchanged-line-format= --old-line-format= --new-line-format='%L' .$1.sorted .$2.sorted`
    if [ -n "$diff" ]
    then
        rm .$1.sorted
        rm .$2.sorted
        echo "$diff"
    fi
}

function upgradeNenv() {
    freeze > .installed.txt
    installing=`packagesToInstall .installed.txt $1`
    echo "$installing" | while read -r line ; do
        echo "INSTALLING $line from npm"
    done
}
