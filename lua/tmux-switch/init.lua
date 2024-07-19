local util = require('tmux-switch.util')

local telescope_actions      = require('telescope.actions')
local telescope_action_state = require('telescope.actions.state')
local telescope_finders      = require('telescope.finders')
local telescope_pickers      = require('telescope.pickers')
local telescope_sorters      = require('telescope.sorters')
local telescope_themes       = require('telescope.themes')

local M = {}

function M.switch()
    local tmux_sessions = util.get_tmux_sessions()
    local opts = telescope_themes.get_dropdown({})

    telescope_pickers.new(opts, {
        prompt_title = 'TMUX sessions',

        finder = telescope_finders.new_table {
            results = tmux_sessions,
        },

        sorter = telescope_sorters.get_generic_fuzzy_sorter(opts),

        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selected_session = telescope_action_state.get_selected_entry()
                telescope_actions.close(prompt_bufnr)
                vim.fn.system('tmux switch -t ' .. selected_session.value)
            end)
            return true
        end,

    }):find()
end

return M

