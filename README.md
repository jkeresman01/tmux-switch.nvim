## The problem :warning: ##
You open Neovim, your preferred editor, and can't navigate switch to another TMUX session witouth leaving Neovim, or you just have many open sessions and wan't to switch fuzzy search for easier navigation within neovim.

## The solution :trophy: ##

Tmux Switch is a Neovim plugin that allows you to switch between TMUX sessions using fuzzy find functionality.

[![asciicast](https://asciinema.org/a/PriVhn7PnlcLsKmzzEHhEc2kz.svg)](https://asciinema.org/a/PriVhn7PnlcLsKmzzEHhEc2kz)

### Functionalities :pick: ###

- [x] Fuzzy find trough all tmux session and navigate to selected one
- [x] Floating UI for creating new sessions
- [ ] Quick switch between 2 most used sessions

### Installation :star: ###
* Make sure you have Neovim v0.9.0 or greater. :exclamation:
* Dependecies: nui && telescope && plenary (telescope dep)
* Install using you plugin manager

***

use {
 , -- Dependency for NUI
  'nvim-lua/popup.nvim',  -- Optional: for enhanced popup functionality
  'nvim-telescope/telescope.nvim', -- For Telescope functionalities
  'MunifTanjim/nui.nvim' -- NUI plugin
}


`Vim-Plug`  
```lua
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug ''MunifTanjim/nui.nvim'
```

`Packer`
```lua

use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use 'MunifTanjim/nui.nvim'

use 'jkeresman01/jkeresman01/tmux-switch.nvim'
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

















