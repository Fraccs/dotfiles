# dotfiles

> ⚙️ My personal configuration files.

> [!WARNING]
> Work in progress! Expect changes and things not working as they should!

## Table of contents

<!--toc:start-->
- [dotfiles](#dotfiles)
  - [Table of contents](#table-of-contents)
  - [Intro](#intro)
  - [Installation](#installation)
  - [Why](#why)
    - [Why this repo](#why-this-repo)
    - [Why doing it this way](#why-doing-it-this-way)
  - [Some docs](#some-docs)
    - [The complexity of versioning dotfiles](#the-complexity-of-versioning-dotfiles)
      - [Gitignore black magic](#gitignore-black-magic)
      - [Different devices with different needs](#different-devices-with-different-needs)
    - [i3 configuration](#i3-configuration)
      - [i3 keymaps](#i3-keymaps)
    - [Neovim configuration](#neovim-configuration)
      - [Neovim plugins](#neovim-plugins)
      - [Neovim keymaps](#neovim-keymaps)
<!--toc:end-->

## Intro

Reading this document top-to-bottom will give you a basic understanding of what is going on in this repository.

Feel free to use this repository as a guideline if you think that it might fit your usecase.

## Installation

> [!NOTE]
> If installing dotfiles on a machine that has an hostname different from `laptop` or `desktop` you **MUST** specify the preferred configuration by setting the `DOTFILES_TARGET` environment variable to either `laptop` or `desktop`.

Run the following command to install the dotfiles on `laptop` or `desktop`:

```sh
curl -sfL https://raw.githubusercontent.com/fraccs/dotfiles/refs/heads/main/.install.sh | sh
```

Run the following command to install the dotfiles on a different machine (*make sure to set the `DOTFILES_TARGET` environment variable properly*):

```sh
curl -sfL https://raw.githubusercontent.com/fraccs/dotfiles/refs/heads/main/.install.sh | [DOTFILES_TARGET=<laptop|desktop>] sh
```

The home directory is now a git repository and it is possible to run git commands in it, but **only the files/directories listed in the `.gitignore` will be versioned**.

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

My current situation: my two main devices are a Huawei laptop (let's call it `laptop` from now on), and a tower desktop (from now on `desktop`). They both are single-boot ArchLinux installations and I'd like to use my dotfiles on both of them.

*Well... "What's the problem?"*

Problems start arising when, for instance, your devices have very different screen resolutions (like mine).

The simplest way to explain this is the `kitty.conf` file: on `desktop` kitty works completely fine with `font_size 11.0` (same as the system's font size) whereas on `laptop` the minimum `font_size` to have an enjoyable experience is `15.0`.

*You see where I'm going with this...*

Some config files can be somewhat different based on what system they are being used on. Of course I had to find a convenient way to make this all work without betraying the philosophy of this repository: **one clone and you're done**.

The solution I came up with leverages symlinks, to be precise the [install script](https://github.com/Fraccs/dotfiles/blob/main/.install.sh) symlinks the config files that follow the format `<name>.<desktop|laptop>[.<extension>]` to `<name>[.<extension>]` depending on the hostname of the machine where the clone happened.

### i3 configuration

#### i3 keymaps

| Mode | Keymap | Description |
| ---- | ------ | ----------- |
| `default` | `$mod+Return` | Open an i3-sensible-terminal |
| `default` | `$mod+q` | Kill the focused container |
| `default` | `$mod+d` | Open rofi in drun mode (shows only applications that provide a .desktop entry) |
| `default` | `$mod+w` | Open rofi in window mode (shows open windows) |
| `default` | `$mod+h` | Change focus to the left |
| `default` | `$mod+j` | Change focus down |
| `default` | `$mod+k` | Change focus up |
| `default` | `$mod+l` | Change focus to the right |
| `default` | `$mod+Shift+h` | Move the focused window left |
| `default` | `$mod+Shift+j` | Move the focused window down |
| `default` | `$mod+Shift+k` | Move the focused window up |
| `default` | `$mod+Shift+l` | Move the focused window right |
| `default` | `$mod+u` | Split in horizontal orientation |
| `default` | `$mod+v` | Split in vertical orientation |
| `default` | `$mod+f` | Enter fullscreen mode for the focused container |
| `default` | `$mod+e` | Toggle split layout |
| `default` | `$mod+a` | Focus the parent container |
| `default` | `$mod+b` | Focus the child container |
| `default` | `$mod+<workspace_number>` | Switch to `<workspace_number>` |
| `default` | `$mod+Shift+<workspace_number>` | Move focused container to `<workspace_number>` |
| `default` | `$mod+Shift+c` | Reload i3 |
| `default` | `$mod+Shift+r` | Restart i3 |
| `default` | `$mod+Shift+e` | Exit i3 (logs you out of your X session) |
| `default` | `$mod+r` | Enter `resize` mode |
| `default` | `Print` | Take a screenshot of every monitor |
| `default` | `Shift+Print` | Take a screenshot of the selected area |
| `default` | `Ctrl+Print` | Take a screenshot of every monitor (saved to clipboard) |
| `default` | `Ctrl+Shift+Print` | Take a screenshot of the selected area (saved to clipboard) |
| `resize` | `h` | Shrink width of 10 px/10 ppt |
| `resize` | `j` | Grow height of 10px/10 ppt |
| `resize` | `k` | Shrink height of 10px/10 ppt |
| `resize` | `l` | Grow width of 10px/10 ppt |
| `resize` | `Return` | Enter `default` mode |
| `resize` | `Escape` | Enter `default` mode |
| `resize` | `$mod+r` | Enter `default` mode |

### Neovim configuration

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
| [vim-sleuth](https://github.com/tpope/vim-sleuth) | Heuristic adjustment of `shiftwidth`, `expandtab` and more, based on the current file or files of the same type in the current and parent directories |
| [vimtex](https://github.com/lervag/vimtex) | Neovim filetype for plugin for LaTeX |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Shows the available neovim keybindings in a popup, as you type them |

#### Neovim keymaps

| Mode | Keymap | Description |
| ---- | ------ | ----------- |
| `n` | `<C-f>` | Open Neotree file explorer |
| `n` | `[d` | Go to previous diagnostic message |
| `n` | `]d` | Go to next diagnostic massage |
| `n` | `<leader>e` | Show diagnostic error messages |
| `n` | `<leader>q` | Open diagnostic quickfix list |
| `t` | `<Esc><Esc>` or `<C-\\><C-n>` | Exit terminal mode |
| `n` | `<left>` | Disables left arrow key in normal mode |
| `n` | `<right>` | Disables right arrow key in normal mode |
| `n` | `<up>` | Disables up arrow key in normal mode |
| `n` | `<down>` | Disables down arrow key in normal mode |
| `n` | `<C-h>` or `<C-w><C-h>`| Move focus to the left window |
| `n` | `<C-l>` or `<C-w><C-l>`| Move focus to the right window |
| `n` | `<C-j>` or `<C-w><C-j>`| Move focus to the lower window |
| `n` | `<C-k>` or `<C-w><C-k>` | Move focus to the upper window |
| `i` | `<C-n>` | Select the next item in "select-style" menus |
| `i` | `<C-p>` | Select the previous item in "select-style" menus |
| `i` | `<C-y>` | Confirm a selection in "select-style" menus |
| `i` | `<C-Space>` | Manually trigger a completion for nvim-cmp |
| `i,s?` | `<C-l>` | |
| `i,s?` | `<C-h>` | |
| `n` | `gd` | Goto definition |
| `n` | `gr` | Goto references |
| `n` | `gI` | Goto implementation |
| `n` | `<leader>D` | Type definition  |
| `n` | `<leader>ds` | Document symbols |
| `n` | `<leader>ws` | Workspace symbols |
| `n` | `<leader>rn` | Rename symbol |
| `n` | `<leader>ca` | Code action |
| `n` | `K` | Hover documentation |
| `n` | `gD` | Goto declaration |
| `n` | `<leader>sh` | Search help |
| `n` | `<leader>sk` | Search keymaps |
| `n` | `<leader>sf` | Search files |
| `n` | `<leader>ss` | Search select telescope |
| `n` | `<leader>sw` | Search current word |
| `n` | `<leader>sg` | Search by grep |
| `n` | `<leader>sd` | Search diagnostics |
| `n` | `<leader>sr` | Search resume |
| `n` | `<leader>s.` | Search recent files |
| `n` | `<leader><leader>` | Find existing buffers |
| `n` | `<leader>/` | Current buffer fuzzy find |
| `n` | `<leader>s/` | Open files fuzzy find |
| `n` | `<leader>sn` | Search neovim config files |
