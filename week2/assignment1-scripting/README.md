# Scripting
Automate simple tasks using Linux shell scripts. In this assignment we will start with the basic of Linux scripting. Here you will get the chance to build your own utilities toolbox.

## Resources
### Introduction
**Video:** [Terminal vs. Bash vs. Command line vs. Prompt](https://www.youtube.com/watch?v=hMSByvFHOro)
This video answers the question what is a shell and what is the terminal.

**Tutorial:** [Shell Scripting Tutorial: How to Create Shell Script in Linux/Unix](https://www.guru99.com/introduction-to-shell-scripting.html)
Shell Scripting is a program to write a series of commands for the shell to execute. It can combine lengthy and repetitive sequences of commands into a single and simple script that can be stored and executed anytime which, reduces programming efforts.

### Shell programming
**Tutorial:** [Shell Scripting Tutorial](https://www.shellscript.sh/index.html)
A tutorial into shell scripting. Read chapters 1 to 11 (so 11 yes, 12 no).

**Video:** [Shell Scripting Crash Course - Beginner Level](https://youtu.be/v-F3YLd6oMw?t=199)
This is an intro to shell scripting with Bash. We will learn what shell scripting is and create a cheat sheet with things like variables, conditionals, loops, functions, etc. We will also do things like rename multiple files.

### (Optional) Scripting cheat sheet and troubleshooting
**Cheat sheet:** [Cheat Sheet Gist](https://gist.github.com/bradtraversy/ac3b1136fc7d739a788ad1e42a78b610)

**Article:** [Stay Out of Trouble](https://linuxcommand.org/lc3_wss0090.php)
A look at some common mistakes that you might run into.

**Article:** [Shell Script Best Practices](https://sharats.me/posts/shell-script-best-practices/)
A few quick rules of thumb that can help you in writing safe and clean shell scripts.

## Assignment
### 1. Higher or lower
**Tutorial:** [Generating Random Numbers In Bash With Examples](https://linuxconfig.org/generating-random-numbers-in-bash-with-examples)
Shows how to generate random numbers in a shell script.

As a primer into shell scripting we will ask you to build a simple game called 'Higher Lower'. The rules of the game are simple:

- the program picks a target - a random number (between 0 and 1.000) - when it starts
- the program asks for the user to enter a number
- if the entered number is higher then the target the program prints "Your guess was higher"
- if the entered number is lower then the target the program prints "Your guess was lower"
- as long as the target has not been guessed the program keeps asking the user to enter a number
- if the number is equal to the target the program prints that the guess is correct, displays the number of tries and exits. 


### 2. Write a safe delete
Write, as a script, a "safe" delete command. Create a file called *trash.sh*. Be sure to add the proper *shebang* and set the file mode so that it can be executed (using the `chmod` command).
    
Executing the script without any arguments should display the following help menu.
```sh
Usage:
    trash <file>     : Moves the file to the trash.
    trash -l         : Lists all the files in the trash.
    trash -r <file>  : Moves the file from the trash to the current directory.
```

Filenames passed as command-line arguments to this script are not deleted, but instead moved to a /home/username/trash directory. Be sure to create the directory if it does not yet exist. 

An example of how the script would work looks like this:
```sh
$ touch delete.me
$ ls
delete.test
$ ls ~/trash
$ ./trash delete.me
$ ls
$ ls ~/trash
delete.me
$ ./trash -l
Currently in trash:
total 0
-rw-r--r--  1 tse01  staff  0 Jun  7 13:35 delete.me
$ ./trash -r delete.mine
ERROR: No file or directory with the name 'delete.me' in trash.
$ ./trash -r delete.me
Restored 'delete.me'.
$ ls
delete.me
$ ./trash -l
Currently in trash:
$ _
```

### 3. Write an archiver
**Documentation:** [inotifywait(1) - Linux man page](https://linux.die.net/man/1/inotifywait)

**Documentation:** [date(1) - Linux man page](https://linux.die.net/man/1/date)

**Article:** [What is Symbolic link in Linux and why is it used?](https://linuxhandbook.com/symbolic-link-linux/)
A symbolic link, also known as a symlink or a soft link, is a special type of file that simply points to another file or directory.

Your task is to create an archive utility script. The purpose of the script is to automatically archive files in a certain directory structure. In the archive files are organized in the following directory structure: `~/archive/<year>/<month>/<day>`

The way the archive script works is as follows:

- In the home directory there is a folder called 'archive'.
- Any file that is moved to this directory will be moved from the 'archive' directory to the correct (sub) directory, for example 'archive/2021/05/24/'. You can use the Linux 'date' command to get the current year, month and day (see man page).
- The archive script listens for files that have been moved to the 'archive' directory (so only moved files not files that have been copied to this directory). The 'inotifywait' command can be used to listen for 'move_to' events in the archive directory (see man page). You will need to install the 'inotify-tools' package using `apt-get` in order to be able to use it.
- With the `inotifywait` command you can listen to a specific directory for new files. The command will not tell you the name of the file that has been moved to the directory. Instead your script will need to list the files in the directory that have not yet been added to a sub directory (an 'archive/<year>/<month>/<day> folder that is). Use the 'find' command to list only files in the archive directory (so exclude directories) and be sure to only look for files in the archive directory and not in the sub directories (something with 'maxdepth').
- Additionally your program should create a symbolic link on the Desktop that links to the archive folder. This makes it easy to move the files from your desktop to your archive.

 ### 4. Extend the archiver
**Tutorial:** [How to Run Linux Commands in Background](https://linuxize.com/post/how-to-run-linux-commands-in-background/)
A background process is a process/command that is started from a terminal and runs in the background, without interaction from the user. This article explains how this works on Linux.

Create parameters 'start' and 'stop' for the archiver script so that it runs in the background. Update your script so that it takes 'start' as a parameter which runs the script in the background (using the ampersand ('&') after the command).  Stopping the script can be done using the `kill <PID>` command. If you want to find the PID of a running process you can run `pgrep archive.sh`. 

With this information is should be possible to adjust your script so that you can run `archive start` which creates the necessary folders and links and starts listening for files (in the background), and `archive stop` which locates the PID of the archive script, kills it (and maybe remove the symbolic link from the desktop, but keeping the archive folder in the home directory).  

            
### 5. Fix my script
In the template a simple sum script has been supplied. In addition a list of numbers is has been supplied (stored in the file *numbers.data*). You can run the script as follows:
```
$ ./sum.sh numbers.data
Sum is: 659
```

There is something wrong with the script however. If you look at the contents of *numbers.data* you will see that the following numbers are supplied: 132, 053, 361, 123. The sum of these numbers however is 669 (check for your self if you like) and not 659. Fix the script so that it properly computes the sum of these numbers.
