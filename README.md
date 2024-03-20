# dotfiles

> ⚙️ My personal configuration files.

## Table of contents

1. [Intro](#intro)
2. [Why](#why)
    - [Why this repo](#why-this-repo)
    - [Why doing it this way](#why-doing-it-this-way)
3. [Some docs](#some-docs)
    - [The complexity of versioning dotfiles](#the-complexity-of-versioning-dotfiles)
    - [First clone guide](#first-clone-guide)

## Intro

Reading this document top-to-bottom will give you a basic understanding of what is going on in this repository.

Feel free to use this repository as a guideline if you think that it might fit your usecase.

*To myself*: go to the [first clone guide](#first-clone-guide) if you're in a hurry.

## Why

### Why this repo

The purpose of this repository is versioning my configuration files and keeping them syncronized between devices.

### Why doing it this way

Turning the **home directory** into a **git repository** and "whitelisting" the files to track felt like the most logical way to version dotfiles, especially if the configuration is used on multiple devices where a change has to be reflected amongst all of them.

## Some docs

### The complexity of versioning dotfiles

Versioning configuration files with git adds some complexity, this is because dotfiles have to be placed in specific locations of the home directory.
Since the home directory contains many files that don't have to be versioned a `.gitignore` with a negation pattern is used to "whitelist" the files to track:

```sh
* # <- Ignore all files in the home directory by default
!.config/nvim/ # <- Track .config/nvim/ (all files and subdirectories in it)
!.gitignore # <- Track .gitignore
...
```

### First clone guide

Run the following commands to clone this repository:

```sh
pwd # /home/<username>
git clone git@github.com:/Fraccs/dotfiles.git
mv dotfiles/.git . # Move the `.git` directory into the home directory
rm -rf dotfiles # Remove the repo (not needed anymore)
git restore . # Restore deleted files (since we moved the .git directory), this will "create" README.md, .gitignore, .config/... inside the home directory
```

The home directory is now a git repository and it is possible to run git commands in it, but **only the files/directories listed in the `.gitignore` will be versioned**.

From now on, changes to the configuration will have to be committed to this repository.

