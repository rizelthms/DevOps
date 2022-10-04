# Linux Basics

## Objective 1: Get your command line working
### Installing Windows Subsystem for Linux
*NOTE: This part only applies if you're using a Windows computer. Mac users can skip this section*

**Tutorial:** [Set up a WSL development environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment)
For Devops we'll be using a lot of Linux software, as that is the operating system that most servers run on. To use Linux on our Windows computer, we have to install the Windows Subsystem for Linux.

Follow the tutorial up to and including the 'Use Visual Studio Code' section and stop after that section.

### Installing Homebrew (MacOS)
*NOTE: This part only applies if you're using a Mac computer. Windows users can skip this section*

MacOS already includes a command line similar to Linux out of the box. We do however need to [install the Homebrew package manager](https://brew.sh), in order to be able to install additional software later on.

---

## Linux Basics
**Video:** [Linux File System/Structure Explained!](https://www.youtube.com/watch?v=HbgzrKJvDRw)
On Linux, files and directories are organized a bit differently than you may be used to on Windows or on OS X. This video explains it all.

**Tutorial:** [Command line for beginners](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview)
Devops often use the command line. This tutorial explains what it is, why we use it and how the basics work. This is important stuff to know! In section 7, this tutorial is using the `apt` command to install new software. This is Ubuntu-specific and doesn't work on MacOS. Feel free to just skip that part.

---

## Objective 2: Demonstrate your command line superpowers!
1. Within this assignment directory (`week1`), create a directory in a directory in a directory. Put the command(s) you used in the `command-line.md` file in this directory, replacing the `TODO` placeholder.

2. Count the number of files and directories that are in the `/usr/bin` directory and its subdirectories, by combining the `find` and the `wc` commands. Put the command in `command-line.md`.

3. Like before, but this time only file names containing the letter `x` should be counted. Use the `grep` command to filter the output of `find`.

4. `/etc/passwd` is a file that contains information about all the users on your computer. Sort the contents of this file line-by-line alphabetically and redirect the output of the sort to a file that you'll call `all-users.txt` in the assignment directory. Copy the command you used into `command-line.md`.