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
    - [Neovim configuration](#neovim-configuration)
      - [Neovim plugins](#neovim-plugins)
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

### Neovim configuration

- Neovim version: `v0.9.5 (self-compiled)`

- Build type: `RelWithDebInfo`

#### Neovim plugins

> More information about the precise commit hash of the installed plugins can be found here: [lazy-lock.json](https://github.com/Fraccs/dotfiles/blob/main/.config/nvim/lazy-lock.json)

| Name | Description |
| ---- | ----------- |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | nvim-cmp source for neovim builtin LSP client |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | nvim-cmp source for filesystem paths |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip (snippets engine) completion for nvim-cmp |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Comments plugin that supports treesitter, line and block comments  |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter for neovim |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | UI for neovim notifications and LSP progress messages, in the bottom right corner of the editor |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Signs for git added, removed and changed lines, navigation between hunks, stage hunks... |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Vertical line to better visualize the indentation level of the scope where the cursor is located |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager for neovim |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine that supports multiple languages
| [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) | Preview (render) a markdown file in a browser window |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Extension for mason.nvim that makes it easier to use lspconfig with mason |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Install and upgrade mason packages automatically |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Package manager for LSP servers, DAP servers, linters and formatters for neovim |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Library of 40+ independent modules improving overall neovim experience |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Filesystem browser for neovim |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI components library for neovim |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Autopairs for different characters |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine for neovim |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for neovim LSP |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Buffer parsing and highlighting |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | HTML tags autoclosing using treesitter |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Icons of all sorts of programming languages, file types and technologies |
| [onedark.nvim](https://github.com/navarasu/onedark.nvim) | Onedark theme for neovim |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Utility functions for other neovim plugins |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF sorter for telescope |
| [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | Sets `vim.ui.select` to telescope |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Highly extensible fuzzy finder for neovim |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Pretty formatting for `TODO`, `FIX`, `WARNING`... comments |
| [vim-sleuth](https://github.com/tpope/vim-sleuth) | Heuristic adjustment of `shiftwidth`, `expandtab` and more, based on the current file or files of the same type in the current and parent directories |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Shows the available neovim keybindings in a popup, as you type them |
