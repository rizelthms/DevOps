#!/bin/bash

# Define the function to print usage instructions
function printUsage() {
    echo "Usage:
    trash <file>     : Moves the file to the trash.
    trash -l         : Lists all the files in the trash.
    trash -r <file>  : Moves the file from the trash to the current directory."
}

#Get the current user's home directory
user_home=$(bash -c "cd ~$(printf %q "$USER") && pwd")

# Parse command line arguments using getopts
while getopts ":lr:" opt; do
    case $opt in
    l) 
        echo "files in the trash:"
        ls -al ~/trash | grep -v '^d' # exclude directories from the list
        ;;
    r)
        FILE=$OPTARG
        if [ ! -f ~/trash/"${FILE}" ]; then # check if the file exists in trash
            echo "not a file"
        else
            mv ~/trash/"${FILE}" . # move file from trash to current directory
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

# If no options were specified, assume the first argument is a file to be moved to trash
if [ $OPTIND -eq 1 ]; then
    if [ $# -eq 1 ]; then

        FILE=$1

    # Create the trash directory if it doesn't exist yet
        if [ ! -d "$user_home"/trash ]; then
            mkdir "$user_home"/trash
            echo "trash directory created"
        fi

        if [ ! -f "$FILE" ]; then # check if file exists
            echo "not a file"
        else
            mv "$FILE" ~/trash # move file to trash directory
        fi

    else # If there are no options and more than one argument, print usage instructions
        printUsage
        exit 1
    fi
fi
