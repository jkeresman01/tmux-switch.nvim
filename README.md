<div align="center">

  <h1>tmux-switch.nvim</h1>
  <h6>Neovim plugin that allows you to switch between tmux sessions, right from Neovim, using fuzzy find functionality.</h6>

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim 0.10](https://img.shields.io/badge/Neovim%200.10-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)
![Work In Progress](https://img.shields.io/badge/Work%20In%20Progress-orange?style=for-the-badge)

</div>

## Table of Contents

- [The problem](#problem)
- [The solution](#solution)
- [Repository structure](#repo)
- [Functionalities](#functionalities)
- [Installation](#installation)
    - [Vim-Plug](#vimplug)
    - [Packer](#packer)
- [Commands](#commands)
- [Setup](#setup)


## The problem :warning: <a name="problem"></a> ##
When you are in Neovim, switching between multiple TMUX sessions can be cumbersome, requiring you to leave your editor and manually navigate the command line. This disrupts your workflow, especially when managing numerous sessions. The constant context-switching between the terminal and Neovim slows down productivity and can be frustrating for users who need a more seamless experience.
***

## The solution :trophy: <a name="solution"></a> ##

TMUX Switch solves this problem by integrating fuzzy search within Neovim, allowing you to quickly switch between TMUX sessions without leaving your editor. By using this plugin, you can navigate and manage your TMUX sessions directly from Neovim which improves your overall productivity.

[![asciicast](https://asciinema.org/a/27TU99A43TXp2578nZfWcKiZ6.svg)](https://asciinema.org/a/27TU99A43TXp2578nZfWcKiZ6)

***

## Repository structure :open_file_folder: <a name="repo"></a> ##

```bash
tmux-switch.nvim/
├── LICENSE
├── lua
│   └── tmux-switch
│       ├── commands.lua    # Commands exposed to Neovim
│       ├── init.lua        # Plugin entry point
│       ├── tmux.lua        # Tmux commands related logic
│       ├── ui.lua          # UI logic (pickers and layout)
│       └── util.lua        # Utility functions
└── README.md
```
***

## Functionalities :pick: <a name="functionalities"></a> ##

- [x] Fuzzy find trough all tmux session and navigate to selected one
- [x] Floating UI for creating new sessions
- [x] Floating UI for renaming current session
- [ ] Quick switch between 2 most used sessions (works when the `sort_by_recent_use` option is set to true, then just enter the `:TmuxSwitch` command and select the first one)
***

## Installation :star: <a name="installation"></a> ##
 * Make sure you have Neovim v0.9.0 or greater. :exclamation:
 * Dependecies: nui && telescope && plenary (telescope dep)
   + can be used without telescope, when the config option `not_use_telescope` is set to true. Then `vim.ui.select` is used.
 * Install using you plugin manager


#### Vim Plug <a name="vimplug"></a> ####
```lua
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug 'jkeresman01/tmux-switch.nvim'
```
***

#### Packer <a name="packer"></a> ####
```lua

use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use 'MunifTanjim/nui.nvim'

use 'jkeresman01/tmux-switch.nvim'
```
***

## Commands :wrench: <a name="commands"></a> ##

Following commands have been exposed to Neovim:

`Commands`
```lua

:TmuxSwitch             -- Lunch picker (select tmux session to switch to)
:TmuxCreateSession      -- Create new session and give it a name
:TmuxRenameSession      -- Rename current tmux session

```

***

## Setup :wrench: <a name="setup"></a> ##

Set the keybindings as you see fit, here is one example:

```lua
require('tmux-switch').setup()

vim.keymap.set("n", "<C-f>", "<CMD>TmuxSwitch<CR>")
vim.keymap.set("n", "<leader>cs", "<CMD>TmuxCreateSession<CR>"
vim.keymap.set("n", "<leader>rs", "<CMD>TmuxRenameSession<CR>"

```
***

| Keybindings   | Action                                                             |
|---------------|--------------------------------------------------------------------|
| `<C-f>`       | Lunch TMUX switch UI (fuzzy search trough tmux sessions)           |
| `<leader>cs`  | Lunch TMUX switch UI (create new TMUX session and name it)         |
| `<leader>rs`  | Lunch TMUX switch UI (rename current TMUX session)                 |
