--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: commands.lua
-- Author: Josip Keresman

local tmux = require("tmux-switch.tmux")

local M = {}

function M.register(config)
    vim.api.nvim_create_user_command("TmuxSwitch", function()
        tmux.switch(config)
    end, {
        desc = "Run tmux switch picker",
    })

    vim.api.nvim_create_user_command("TmuxCreateSession", function()
        tmux.create_session()
    end, {
        desc = "Create new tmux session",
    })

    vim.api.nvim_create_user_command("TmuxRenameSession", function()
        tmux.rename_session()
    end, {
        desc = "Rename current tmux session",
    })
end

return M
