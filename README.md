# dotfiles

> ⚙️ My personal configuration files.

## Table of contents

<!--toc:start-->
- [dotfiles](#dotfiles)
  - [Table of contents](#table-of-contents)
  - [Intro](#intro)
  - [Why](#why)
    - [Why this repo](#why-this-repo)
    - [Why doing it this way](#why-doing-it-this-way)
  - [Some docs](#some-docs)
    - [The complexity of versioning dotfiles](#the-complexity-of-versioning-dotfiles)
      - [Gitignore black magic](#gitignore-black-magic)
      - [Different devices with different needs](#different-devices-with-different-needs)
    - [First clone guide](#first-clone-guide)
<!--toc:end-->

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
* # <- Ignore everything
!.config # <- I want to version stuff inside `.config`
!.config/nvim # <- I want to version stuff inside `.config/nvim`
!.config/nvim/** # <- Track .config/nvim/** (all files and subdirectories in it)
!.gitignore # <- Track .gitignore
...
```

#### Gitignore black magic

Tracking every file in every subdirectory of `.config/nvim/` can only be accomplished with the following negations:

```sh
*
!.config
!.config/nvim
!.config/nvim/**
```

Each of the 3 negations is needed because git in order to reach files inside `.config/nvim/`, must be able to reach `.config/nvim` first, and in order to reach `.config/nvim`, it must be able to reach `.config` first.

#### Different devices with different needs

> What if you had multiple devices where you'd like to use your dotfiles, but those devices (*because of their nature*) had slightly different needs from one another?

My current situation: my two main devices are a Huawei laptop (let's call it `laptop` from now on), and a tower desktop (from now on `desktop`). They both are single-boot Debian 12 installations and I'd like to use my dotfiles on both of them.

*Well... "What's the problem?"*

Problems start arising when, for instance, your devices have very different screen resolutions (like mine).

The simplest way to explain this is the `kitty.conf` file: on `desktop` kitty works completely fine with `font_size 11.0` (same as the system's font size) whereas on `laptop` the minimum `font_size` to have an enjoyable experience is `15.0`.

*You see where I'm going with this...*

Some config files can be somewhat different based on what system they are being used on. Of course I had to find a convenient way to make this all work without betraying the philosophy of this repository: **one clone and you're done**.

The solution I came up with leverages symlinks and git hooks, to be precise the `post-checkout` hook. Instead of a single `kitty.conf` file, I created `kitty.desktop.conf` and `kitty.laptop.conf`, then, when the repository is cloned, the `post-checkout` hook runs a script that creates the correct symlink (named `kitty.conf`) that points to either `kitty.desktop.conf` or `kitty.laptop.conf` depending on the `hostname` of the machine where the clone happened.

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

