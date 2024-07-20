## The problem :warning: ##
When you are in Neovim, switching between multiple TMUX sessions can be cumbersome, requiring you to leave your editor and manually navigate the command line. This disrupts your workflow, especially when managing numerous sessions. The constant context-switching between the terminal and Neovim slows down productivity and can be frustrating for users who need a more seamless experience.

## The solution :trophy: ##

TMUX Switch solves this problem by integrating fuzzy search within Neovim, allowing you to quickly switch between TMUX sessions without leaving your editor. By using this plugin, you can navigate and manage your TMUX sessions directly from Neovim which improves your overall productivity.

[![asciicast](https://asciinema.org/a/27TU99A43TXp2578nZfWcKiZ6.svg)](https://asciinema.org/a/27TU99A43TXp2578nZfWcKiZ6)

### Functionalities :pick: ###

- [x] Fuzzy find trough all tmux session and navigate to selected one
- [x] Floating UI for creating new sessions
- [ ] Quick switch between 2 most used sessions

### Installation :star: ###
* Make sure you have Neovim v0.9.0 or greater. :exclamation:
* Dependecies: nui && telescope && plenary (telescope dep)
* Install using you plugin manager

***

`Vim-Plug`  
```lua
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug 'jkeresman01/tmux-switch.nvim'
```

`Packer`
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

## Key - mapings :musical_keyboard: ##

Set the keymapings as you see fit, here is one example:

```lua
local tmux = require('tmux-switch')

vim.keymap.set("n", "<C-f>", function () tmux.switch() end)
vim.keymap.set("n", "<leader>cs", function () tmux.create_session() end)
```
***

| Key - map     | Action                                                             |
|---------------|--------------------------------------------------------------------|
| `<C-f>`       | Lunch TMUX switch UI (fuzzy search trough tmux sessions)           |
| `<leader>cs`  | Lunch TMUX switch UI (create new TMUX session and name it)         |

















