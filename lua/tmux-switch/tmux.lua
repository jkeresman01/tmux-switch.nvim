local util = require("tmux-switch.ui")

local M = {}

--- Switch to an existing tmux session using a picker menu.
function M.switch()
    local tmux_sessions = util.get_tmux_sessions()
    ui.show_tmux_session_picker(tmux_sessions)
end

--- Create a new tmux session and switch to it.
function M.create_session()
    ui.create_input_prompt("[ TMUX switch ]", "", function(session_name)
        util.create_new_session(session_name)
        util.switch_to_session(session_name)
    end)
end

--- Rename the current tmux session.
function M.rename_session()
    local current_session = util.get_current_tmux_session()
    ui.create_input_prompt("[ TMUX switch ]", current_session, function(new_session_name)
        util.rename_current_session(new_session_name)
    end)
end

return M
