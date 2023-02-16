# Assignment 1: Command-line


## 1. Command(s) to create a directory in a directory in a directory:

mkdir -p directory1/directory2/directory3

## 2. Command to count the files and directories in `/usr/bin` (and its subdirectories):

find /usr/bin -type f | wc -l

## 3. Command to count the files and directories that have the letter `x` in their names in `/usr/bin` (and its subdirectories):

find /usr/bin | grep -c x

## 4. Command to sort `/etc/passwd` and write the output to a file:

sort /etc/passwd > all-users.txt
