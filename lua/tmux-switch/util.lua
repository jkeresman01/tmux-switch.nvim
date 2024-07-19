local M = {}

function M.get_tmux_sessions()
    local list_tmux_sessions = "tmux ls | awk -F ':' '{print $1}'"
    local handle = io.popen(list_tmux_sessions)

    if not handle then
        vim.notify("No can do!")
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

return M
