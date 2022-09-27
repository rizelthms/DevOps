#!/bin/bash
if [ $# == 0 ]
then
    echo "Please supply a data set"
else
    declare -i SUM=0
    while read -r X ; do
        SUM+=$X
    done < "$1"
    echo "Sum is: $SUM"
fi

