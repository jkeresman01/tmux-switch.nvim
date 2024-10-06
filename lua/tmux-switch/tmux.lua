local ui = require("tmux-switch.ui")
local util = require("tmux-switch.util")

local M = {}

-- Switches to a different tmux session
--
-- This function retrieves the available tmux sessions and displays a picker
-- for the user to select a session to switch to.
--
-- @return nil
function M.switch()
    local tmux_sessions = util.get_tmux_sessions()
    ui.show_tmux_session_picker(tmux_sessions)
end

-- Creates a new tmux session
--
-- This function prompts the user to input a session name, creates a new tmux
-- session with the given name, and switches to it.
--
-- @return nil
function M.create_session()
    ui.create_input_prompt("[ TMUX switch ]", "", function(session_name)
        util.create_new_session(session_name)
        util.switch_to_session(session_name)
    end)
end

-- Renames the current tmux session
--
-- This function prompts the user to rename the current tmux session. The prompt
-- is pre-filled with the current session name for easy editing.
--
-- @return nil
function M.rename_session()
    local current_session = util.get_current_tmux_session()
    ui.create_input_prompt("[ TMUX switch ]", current_session, function(new_session_name)
        util.rename_current_session(new_session_name)
    end)
end

return M
