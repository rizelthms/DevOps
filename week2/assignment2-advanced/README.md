# Advanced Scripting
Welcome back script kiddies!

## Resources
**Documentation:** [Grep man page](https://man7.org/linux/man-pages/man1/grep.1.html)

**Tutorial:** [Special variables in Linux](https://www.tutorialspoint.com/unix/unix-special-variables.htm)

## Tasks
### Install the Poetry tool
To be able to run the software provided to you in this assignment, please [install the Python poetry tool](https://python-poetry.org/docs/#installation) by following the instructions on its website.

### Set up Cron (Windows only)
If you're using a Windows computer, [configure and start the Cron scheduler](https://www.howtogeek.com/746532/how-to-launch-cron-automatically-in-wsl-on-windows-10-and-11/) before continuing with the assignments.

### Install GNU Tar (MacOS only)
If you're using a Mac computer, you should install GNU tar using `brew install gnu-tar` before you continue. Use the command `gtar` instead of `tar` in the assignments below.

## Assignment
### 1. Compress the trash
**Tutorial:** [How to Compress and Extract Files Using the tar Command on Linux](https://www.howtogeek.com/248780/how-to-compress-and-extract-files-using-the-tar-command-on-linux/)
The tar command on Linux is often used to create .tar.gz or .tgz archive files, also called “tarballs.” One slight correction: this page shows the use of the `--exclude` option *after* the list of files/directories to compress. This doesn't work, at least not with all `tar` versions. Options should come *before* the list of files/directories.

**Tutorial:** [How to use cron in Linux](https://opensource.com/article/17/11/how-use-cron-linux)
The cron service for Linux allows you to schedule tasks or scripts to be executed periodically.

**Video:** [Linux Tip: How to use the crontab command](https://www.youtube.com/watch?v=llUw3RtD-Yw)

In the previous assignment you have implemented a simple trash utility script. Now suppose we'd like to automatically compress all files that are in the trash every day.

First step would be to extend your script so that you can instruct it to create a "tarball" (a `.tar.gz` archive) from all files currently in the trash directory (for example using 'trash -a'). The archive tarballs should be placed in an `archive/` directory within your trash directory (so that would be `~/trash/archive` for example). When creating a tarball you should take care to exclude the `archive` directory (look in the `tar` man page for help on how to do exclusions). For the filename of the tarball, use the following pattern: `<year>-<month>-<day>-<hour>-<minute>.tar.gz`. When creating the tarball, all added files should be deleted from their original locations (again, take a look at the `tar` man page).

After a successful manual implementation you can use cron to schedule periodical (daily) archiving of the trash. For testing you can use a smaller interval (5 minutes for example).

### 2. Search the trash
**Tutorial:** [How to Search for Files from the Linux Command Line](https://www.linux.com/topic/desktop/how-search-files-linux-command-line/)
Some examples on how to search for files using the command line.

**Tutorial:** [Common Linux Text Search](https://www.baeldung.com/linux/common-text-search)
In this tutorial, we’ll go through some examples together and learn how to perform some common text searching in Linux using the grep command-line utility.

One final feature for our trash is to search for files in the trash. Your script should support two search methods: 

1. For filenames containing the search keyword, and 
2. Full text search (which searches for the keyword within the files).

Implement the searches using different arguments for your script (for example `trash -s <keyword>` and `trash -sf <keyword>`). Start with the search in filenames.

Note that your search should also work for files located in the (compressed) archive of the trash.


### 3. Yahtzee
**Tutorial:** [How to Split String in Bash Script](https://linuxhandbook.com/bash-split-string/)
In this tutorial several ways of splitting a string in a shell script is shown.

In the supplied template directory you will find a simple web application. The application returns a list of five random integers (between 1 and 6). Install the dependencies for the application using `poetry install`. Start the application with `poetry run python web.py`. It should expose the following URL: [http://localhost:5000](http://localhost:5000)

Write a script that periodically (every sec) queries the web application (using the `curl` command, be sure to run it silently). On every attempt the script should check whether the numbers form a "three of a kind", "four of a kind" or "Yahtzee".

*Hint:* you may want to use the `sort` and `uniq` commands.

### 4. Test the Yahtzee webapp
Write a script that makes 100 request to the Yahtzee web server. Each time use `curl` to perform one of the following types of request, selecting randomly:

1. Some request work fine (see previous objective) and give a 200 status code.
2. Some request are to /error which give a 500 status code.
3. Some request are to random pages that do not exist and give a 404 status code.

Count how often you made each of the three types of requests.

Next, verify that the last 100 lines in the `access.log` contain log entries for these exact amounts of request types (matching the status codes).
