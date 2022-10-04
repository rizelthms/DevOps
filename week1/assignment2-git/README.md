# Git Introduction
An introduction to source control

## Resources
**Tutorial:** [Atlassian = What is version control?](https://www.atlassian.com/git/tutorials/what-is-version-control)
Version control systems are a category of software tools that help a software team manage changes to source code over time. Version control software keeps track of every modification to the code in a special kind of database.

**Video:** [What is VCS? (Git-SCM) - Git Basics](https://www.youtube.com/watch?v=8oRjP8yj2Wo)
A meaningful discussion of the value of Git begins with a solid understanding of what version control is and what it does for software developers, document authors, and designers. In this screencast, I share the basic ideas of version control and the motivations for using it.

**Tutorial:** [freecodecamp - What is git and how to use it](https://www.freecodecamp.org/news/what-is-git-and-how-to-use-it-c341b049ae61/)
Git is an Open Source Distributed Version Control System. Now that’s a lot of words to define Git.

---

In this assignment you will learn the basic Git commands. For now you will learn how to use Git from the command line. There are some fancy tools for managing your Git repository. Unfortunately you are not allowed to use them in this assignment.

## Tasks
### 1. Install Git
Go to this link containing details on how to install Git in multiple operating systems: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
        
### 2. Configure Git
Before you really get started with Git, it is important that you have set up the configuration of Git (on your laptop) correctly. Go to your terminal and type the following (use your Saxion student email address):
```
git config --global user.name "<your name>"
git config --global user.email <your email address>
```
You can check whether the configuration has been set up correctly with the following commands:
```
git config --global user.name
git config --global user.email
```
**Note:** These settings are specific to your laptop. If you use another machine in addition to your laptop to adjust your code, you must also adjust the Git configuration on this machine as indicated above.

## Assignment
### 1. Create a git repository
In the template folder you will find some files we want to add to a Git repository. Create a new folder - called **git** - in the template folder. Initialize a Git repository (using git init) in this folder and add the 'README.md' and 'diffofill.sh' files from the template folder to the git repository. Note that adding the files is not (only) a matter of copy and pasting the files in the proper directory. You should use the 'git add' and 'git commit' commands to add the files to the repository. As a commit message you could 'Initial commit'.

You can use 'git log' to verify your results, which should look something like this:
```
$ git log
commit ecea92461623bfb73e98802632cee4e54cc0caa8 (HEAD -> master)
Author: Timothy Sealy <t.e.sealy@saxion.nl>
Date:   Wed Apr 7 10:21:21 2021 +0200

    1: Initial commit
```

*Tip:* For this assignment it is a good idea to number your commits. This way you can relate the commits to specific objectives.

### 2. Implement a diff script
**Tutorial:** [Saving changes (git add)](https://www.atlassian.com/git/tutorials/saving-changes)
The git add command adds a change in the working directory to the staging area. It tells Git that you want to include updates to a particular file in the next commit.

**Tutorial:** [Git commit](https://www.atlassian.com/git/tutorials/saving-changes/git-commit)
The git commit command captures a snapshot of the project's current changes. Committed snapshots can be thought of as “safe” versions of a project — Git will never change them unless you explicitly ask it to!

Your git repository now contains a shell script called **diffodill.sh**. In this file we're going to implement a script that computes the difference between two files using the `diff` command. The files are passed as arguments to the script. The script prints usage instructions when no arguments are given and an error when an invalid number of arguments are passed. You can use the files in the example directory for testing.

Add this code to your 'diffodill.sh' file:
```bash
#!/bin/sh

if [ $# == 0 ]
then
    echo "Usage: diffodill <file1> <file2>"
elif [ $# -ne 2 ]
then
    echo "Invalid number of arguments"
else
    diff $1 $2
fi
```

When you are finished be sure to commit your changes to your git repository. Please write meaningful commit messages (for example "2: Implemented diff").


### 3. Undoing mistakes
**Tutorial:** [Git revert](https://www.atlassian.com/git/tutorials/undoing-changes/git-revert)
The git revert command can be considered an 'undo' type command, however, it is not a traditional undo operation.

Extend your script so that it shows the differences in colors (use the `--color` flag). Commit this change (give it number "3a"). 

Come to think of it we do not really want to have our results colorized. Undo the change. Make sure that the head of the branch is the same as before the color change (use `git diff <commit_hash_1> <commit_hash_2>` to check this).

*Tip:* Use the `--no-edit` flag to skip editing the commit message. If you are stuck in the (vi) editor then you can type `:wq` to quit and write to file. Instead of typing `:wq` you can also use the `<Shift> zz` (press `z` twice while holding the `<Shift>` key) shorthand. If you want to abort your commit you can type `:q!`. 

### 4. Implement a new feature
**Video:** [Creating and merging branches in Git](https://www.youtube.com/watch?v=S2TUommS3O0)
Learn the basics of creating and merging branches in Git. In Git, branches are a part of your everyday development process. Git branches are effectively a pointer to a snapshot of your changes.

**Tutorial:** [Gitignore Explained: What is Gitignore and How to Add it to Your Repo](https://www.freecodecamp.org/news/gitignore-what-is-it-and-how-to-add-to-repo/)

It is now time to implement a new feature in the script. Be sure to implement the changes on a new branch. First create this branch and switch to it before implementing the following changes.

Extend the script so that the result of the diff is stored in to a file. The file (result.diff) should be stored in a directory called 'output'. We'll do this by adding `> ./output/result.diff` at the end of the line that is calling the `diff` command.

Make sure that the file (results.diff) is not tracked by git, because this is generated when the script is run and depends on the arguments you pass to the script (hint: use gitignore). 

Also note that git does not track empty directories. Your script depends on the 'output' directory to store the results.diff file so you should add a '.keep' file in this directory and check it into git.

Use branching to implement your new feature. Be sure to merge the branch with master.

### 5. Implement more features
**Video:** [How to resolve merge conflicts in Git](https://www.youtube.com/watch?v=xNVM5UxlFSA)
A video explaining how to resolve a merge conflict.

You can pass the `--side-by-side` argument to the diff command to get a side by side comparison (thank you Captain Obvious :). Your assignment is to implement this feature in the script on a NEW branch. Commit your change (number 5a) but do NOT merge the branch yet.

After you have implemented this feature on this branch switch back to the master branch. On the master branch change your script so that the name of the file containing the results is now called 'output.diff'. Commit this change (5b) on the master branch.

Now merge the branch containing the side by side comparison into your master branch. Resolve the merge conflict (if you have none please contact your teacher ;).

### 6. Revert a merge
**Tutorial:** [Git undo merge](https://www.datree.io/resources/git-undo-merge)
Reverting a merge is a little trickier than a reverting a normal commit. In the article the details of undoing a merge are explained.

Unfortunately we are not satisfied with the result of our merge. Your job is to revert the master branch to the point it was before the merge.

### 7. Let's rebase
**Video:** [Git rebase tutorial. Rebase vs Merge](https://www.youtube.com/watch?v=kMvLn8WcAII)

**Tutorial:** [Bitbucket - git rebase](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase)
An in-depth discussion of the `git rebase` command.

Let's try out rebasing. Let's create a new branch from master (it is important you create this branch before committing your upcoming changes to master). Still on master create a 'logs' directory. In this directory create a file as follows:
```sh
$ git log --oneline > logs/master.gitlog
```
Commit (7a) this file to the master branch.

Switch to the previously created feature branch. Do the same on this branch (and save the git log result in logs/branch.gitlog). Commit (7b) this file to the feature branch.

At this point your feature branch is running behind on the master branch. In order to include the latest changes in the feature branch we will rebase the master branch on the feature branch. Let's analyze what happens during a rebase:
1. Create a file in the root of the git directory called 'rebase-analysis.txt'. Execute a `git log --oneline` and paste the output in the file and save it.
2. Rebase the master branch on the feature branch.
3. Execute a `git log --oneline` again and paste the output in the file and save it.
4. Look at the two git log outputs and write down your explanation of what has happened. Hint look at the commit hashes.

When you analysis is complete, commit (7c) the file to the feature branch and merge the branch with master.

### 8. Solving rebase conflicts
1. Create a new feature branch but stay on master.
2. On the master branch implement the side by side comparison in your script and commit it (7a).
3. Switch to the previously created feature branch and implement colorized diff and commit it (7b).

Let's rebase master on the feature branch. The rebase should give a conflict (if you have none please contact your teacher ;). Carefully read the git error message for tips on how to solve the rebase conflict.

After a successful rebase the git log of the feature branch should look something like this:
```
7077a01 (HEAD -> feature_4) 7b: Implemented colorized diff (again)
f617eda (master) 7a: Added side by side comparison (again)
075e718 (feature_3) 6c: Added rebase analysis
9d6e2c9 6b: Added gitlog of feature branch
ae1b243 6a: Added gitlog of master
21c3d7d Revert "5c: Merge branch 'feature_2'"
0ed9bea 5c: Merge branch 'feature_2'
04650eb 5b: Added variable for the result filename
7e59d69 (feature_2) 5a: Implemented side by side comparison
96ba96e (feature_1) 4b: Added .gitignore
750482f 4a: Extended script to write results to file
039dc74 Revert "3a: Implemented colorized diff"
fc79fe1 3a: Implemented colorized diff
10a9d67 2: Implemented diff
64c6631 1: Initial commit
```
