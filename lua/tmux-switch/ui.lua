local util = require("tmux-switch.util")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local nui_input = require("nui.input")
local event = require("nui.utils.autocmd").event

local M = {}

--- General function to handle user input for session-related tasks.
--
-- @param prompt_text The text displayed at the top of the input window.
-- @param default_value The default value to display in the input prompt (if any).
-- @param on_submit function Callback function to execute when the input is submitted.
function M.create_input_prompt(prompt_text, default_value, on_submit)
    local input = nui_input({
        position = "50%",

        size = {
            width = 50,
        },

        border = {
            style = "rounded",
            text = {
                top = prompt_text,
                top_align = "center",
            },
        },

        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        prompt = "> ",
        default_value = default_value or "",

        on_submit = on_submit,
    })

    input:mount()

    input:on(event.BufLeave, function()
        input:unmount()
    end)
end

--- Helper function to create and display a tmux session picker.
-- Allows user to select a tmux session from a dropdown menu.
--
-- @param tmux_sessions List of tmux session names to display.
function M.show_tmux_session_picker(tmux_sessions)
    local opts = themes.get_dropdown({
        layout_config = { width = 50 },
    })

    pickers.new(opts, {
        prompt_title = "TMUX switch",

        finder = finders.new_table({
            results = tmux_sessions,
        }),

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

return M
