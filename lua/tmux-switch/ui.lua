--- Creates an input prompt with customizable text and a default value
--
-- @param prompt_text The text to display at the top of the input prompt
-- @param default_value The default value for the input (optional)
-- @param on_submit The function to call when the user submits the input
--
-- @return nil
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

--- Displays a tmux session picker using Telescope
--
-- @param tmux_sessions A list of tmux sessions to display in the picker
--
-- @return nil
function M.show_tmux_session_picker(tmux_sessions)
    local opts = themes.get_dropdown({
        layout_config = { width = 50 },
    })

    pickers
        .new(opts, {
            prompt_title = "TMUX switch",

            finder = finders.new_table({
                results = tmux_sessions,
            }),

            sorter = sorters.get_generic_fuzzy_sorter(opts),

            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selected_session = action_state.get_selected_entry()
                    if selected_session then
                        util.switch_to_session(selected_session.value)
                    end
                end)
                return true
            end,
        })
        :find()
end

return M
