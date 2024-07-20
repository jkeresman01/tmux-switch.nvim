local M = {}

function M.get_tmux_sessions()
    local list_tmux_sessions_cmd = "tmux ls | awk -F ':' '{print $1}'"
    local handle = io.popen(list_tmux_sessions_cmd)

    if not handle then
        vim.notify "No can do for getting tmux sessions!"
        return {}
    end

    local tmux_ls_results = handle:read("*a")
    handle:close()

    local tmux_sessions = {}
    for session in string.gmatch(tmux_ls_results, "[^\n]+") do
        table.insert(tmux_sessions, session)
    end

    return tmux_sessions
end

function M.switch_to_session(session_name)
    if session_name then
        local switch_to_session_cmd = string.format("tmux switch -t %s", session_name)
        vim.fn.system(switch_to_session_cmd)
    end
end

function M.create_new_session(session_name)
    if session_name and session_name ~= "" then
        local create_new_session_cmd = string.format("tmux new-session -d -s %s", session_name)
        vim.fn.system(create_new_session_cmd)
    end
end

return M
