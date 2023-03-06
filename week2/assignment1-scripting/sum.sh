#!/bin/bash

if [ $# == 0 ]
then
    echo "Please supply a data set"
else
    SUM=$(awk '{ total += $1 } END { print total }' "$1")
    echo "Sum is: $SUM"
fi


