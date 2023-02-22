#!/usr/bin/env bash

# Set the paths for the desktop and archive directories
PATH_DESKTOP=~/Desktop/
PATH_ARCHIVE=~/archive/

# Create the symbolic link on the Desktop
ln -s "$PATH_ARCHIVE" "$PATH_DESKTOP"

# Define the archive function
archive() {
  while true
  do
# Wait for a file to be moved to the archive directory
    inotifywait -e move_to "$PATH_ARCHIVE"

# Create today's archive sub-directory
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
archive_dir=~/"$PATH_ARCHIVE$year$month$day"

# Create today's archive sub-directory if it does not exist
mkdir -p "$archive_dir"

#Move the files to the archive sub-directory
files=$(find "$PATH_ARCHIVE" -maxdepth 1 -type f ! -name ‘.*’)
for file in $files; do
mv "$file" "$archive_dir"
done
done
}

# Start the archive function  
archive

