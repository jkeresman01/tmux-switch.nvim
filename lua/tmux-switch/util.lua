--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: util.lua
-- Author: Josip Keresman

local M = {}

-- Retrieves the list of available tmux sessions
--
-- @return A table containing the names of tmux sessions, or an empty table if an error occurs
function M.get_tmux_sessions(config)
    local list_tmux_sessions_cmd
    if config and config.sort_by_recent_use then
        list_tmux_sessions_cmd =
            "tmux ls -F '#{session_last_attached} #{session_name}' | sort -nr | awk '{print $2}'"
    else
        list_tmux_sessions_cmd = "tmux ls | awk -F ':' '{print $1}'"
    end
    local handle = io.popen(list_tmux_sessions_cmd)

    if not handle then
        vim.notify("No can do for getting tmux sessions!")
        return {}
    end

    local tmux_ls_results = handle:read("*a")
    handle:close()

    local current_session_cmd = "tmux display-message -p '#S'"
    local handle_current = io.popen(current_session_cmd)
    local current_session = handle_current:read("*a"):gsub("\n", "")
    handle_current:close()

    local tmux_sessions = {}
    for session in string.gmatch(tmux_ls_results, "[^\n]+") do
        if session ~= current_session then
            table.insert(tmux_sessions, session)
        end
    end

    return tmux_sessions
end

-- Switches to the specified tmux session
--
-- @param session_name The name of the tmux session to switch to
--
function M.switch_to_session(session_name)
    if session_name then
        local switch_to_session_cmd = string.format("tmux switch -t %s", session_name)
        vim.fn.system(switch_to_session_cmd)
    end
end

-- Creates a new tmux session
--
-- @param session_name The name of the new tmux session to create
--
function M.create_new_session(session_name)
    if session_name and session_name ~= "" then
        local create_new_session_cmd = string.format("tmux new-session -d -s %s", session_name)
        vim.fn.system(create_new_session_cmd)
    end
end

-- Gets the name of the current tmux session
--
-- @return The name of the current tmux session, or `nil` if an error occurs
function M.get_current_tmux_session()
    local display_current_tmux_session_cmd = "tmux display-message -p '#S'"
    local handle = io.popen(display_current_tmux_session_cmd)

    if not handle then
        vim.notify("No can do for get current tmux session!")
        return nil
    end

    local result = handle:read("*a")
    handle:close()

    return result:match("^%s*(.-)%s*$")
end

-- Renames the current tmux session
--
-- @param new_session_name The new name for the current tmux session
--
function M.rename_current_session(new_session_name)
    local rename_current_session_cmd = string.format("tmux rename-session %s", new_session_name)
    vim.fn.system(rename_current_session_cmd)
end

return M
