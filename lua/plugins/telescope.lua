return {
    "nvim-telescope/telescope.nvim",
    branch = "master", -- 0.1.x is frozen (2024) and breaks current_buffer_fuzzy_find with newer nvim-treesitter
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make", -- gcc + make (no cmake installed); produces build/libfzf.dll
        },
        "nvim-telescope/telescope-file-browser.nvim",
        "echasnovski/mini.icons",
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        -- do not forget to install ripgrep ex. in cmd choco install ripgrep
        -- File/Buffer Navigation
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files (project root)" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find recent files" })
        -- (kept off the <leader>s prefix, which leap uses)
        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope file_browser<cr>", { desc = "Browse files (telescope)" })
        vim.keymap.set("n", "<leader>fF", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "Browse current directory" })

        -- Content Search
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by grep (live)" })
        vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })
        vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })
        vim.keymap.set("n", "<leader>fR", builtin.resume, { desc = "Resume last Telescope search" })

        -- Other
        vim.keymap.set("n", "<leader>uC", builtin.colorscheme, { desc = "Preview colorscheme" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search keymaps" })

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "^.git/",
                    "node_modules/",
                    "%.class$",
                },
                layout_strategy = "vertical",
            },
            pickers = {
                colorscheme = { enable_preview = true },
            },
        })

        -- Load extensions
        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "file_browser")
    end,
}
