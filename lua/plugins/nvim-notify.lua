return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            -- Position notifications at bottom right
            top_down = false,  -- Stack from bottom up
            stages = "fade",   -- Animation style
            timeout = 3000,    -- 3 seconds before auto-dismiss
            max_width = 50,
            max_height = 10,
            render = "compact", -- More compact layout

            -- Solid background for transparent terminals
            background_colour = "#1a1b26",  -- Dark blue-gray background (opaque)

            -- Explicitly set position to bottom right
            on_open = function(win)
                vim.api.nvim_win_set_config(win, {
                    relative = "editor",    -- Position relative to editor window
                    anchor = "SE",          -- South-East (bottom-right corner)
                    row = vim.o.lines - 2,  -- 2 lines from bottom
                    col = vim.o.columns,    -- Right edge
                })
            end,
        })

        -- Set notify as default notification handler
        vim.notify = require("notify")
    end,
}
