#!/bin/bash

function printUsage() {
    echo "Usage:
    trash <file>     : Moves the file to the trash.
    trash -l         : Lists all the files in the trash.
    trash -r <file>  : Moves the file from the trash to the current directory."
}

user_home=$(bash -c "cd ~$(printf %q "$USER") && pwd")

while getopts ":lr:" opt; do
    case $opt in
    l)
        echo "files in the trash:"
        ls -al ~/trash | grep -v '^d'
        ;;
    r)
        FILE=$OPTARG
        if [ ! -f ~/trash/"${FILE}" ]; then
            echo "not a file"
        else
            mv ~/trash/"${FILE}" .
        fi
        ;;
    \?)
        echo "Invalid option: -$OPTARG"
        printUsage
        exit 1
        ;;
    :)
        echo "Option -$OPTARG requires an argument."
        printUsage
        exit 1
        ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    if [ $# -eq 1 ]; then

        FILE=$1

        if [ ! -d "$user_home"/trash ]; then
            mkdir "$user_home"/trash
            echo "trash directory created"
        fi

        if [ ! -f "$FILE" ]; then
            echo "not a file"
        else
            mv "$FILE" ~/trash
        fi

    else
        printUsage
        exit 1
    fi
fi
