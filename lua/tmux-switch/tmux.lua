--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: tmux.lua
-- Author: Josip Keresman

local ui = require("tmux-switch.ui")
local util = require("tmux-switch.util")

local M = {}

function M.switch(config)
    local tmux_sessions = util.get_tmux_sessions(config)
    ui.show_tmux_session_picker(tmux_sessions, config.not_use_telescope)
end

function M.create_session()
    ui.create_input_prompt("[ TMUX switch ]", "", function(session_name)
        util.create_new_session(session_name)
        util.switch_to_session(session_name)
    end)
end

function M.rename_session()
    local current_session = util.get_current_tmux_session()
    ui.create_input_prompt("[ TMUX switch ]", current_session, function(new_session_name)
        util.rename_current_session(new_session_name)
    end)
end

return M
