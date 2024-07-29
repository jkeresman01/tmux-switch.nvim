local util = require('tmux-switch.util')

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')

local nui_input = require('nui.input')
local event = require("nui.utils.autocmd").event

local M = {}

function M.switch()
    local tmux_sessions = util.get_tmux_sessions()
    local opts = themes.get_dropdown({
        layout_config = { width = 50 }
    })

    pickers.new(opts, {
        prompt_title = "TMUX switch",

        finder = finders.new_table {
            results = tmux_sessions,
        },

        sorter = sorters.get_generic_fuzzy_sorter(opts),

        attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
                local selected_session = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                util.switch_to_session(selected_session.value)
            end)
            return true
        end,

    }):find()
end

function M.create_session()
    local input = nui_input({
        position = "50%",

        size = {
            width = 50,
        },

        border = {
            style = "rounded",
            text = {
                top = "[ TMUX switch ]",
                top_align = "center",
            },
        },

        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        prompt = "> ",
        default_value = "",

        on_submit = function(session_name)
            util.create_new_session(session_name)
            util.switch_to_session(session_name)
        end,
    })

    input:mount()

    input:on(event.BufLeave, function()
        input:unmount()
    end)
end

function M.rename_session()
    local input = nui_input({
        position = "50%",

        size = {
            width = 50,
        },

        border = {
            style = "rounded",
            text = {
                top = "[ TMUX switch ]",
                top_align = "center",
            },
        },

        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        prompt = "> ",
        default_value = util.get_current_tmux_session(),

        on_submit = function(new_session_name)
            util.rename_current_session(new_session_name)
        end,
    })

    input:mount()

    input:on(event.BufLeave, function()
        input:unmount()
    end)
end


return M

