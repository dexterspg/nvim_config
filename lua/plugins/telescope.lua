return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        "nvim-telescope/telescope-file-browser.nvim",
        "echasnovski/mini.icons",
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        -- do not forget to install ripgrep ex. in cmd choco install ripgrep
        -- File/Buffer Navigation
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files (project)" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find recent files" })
        vim.keymap.set("n", "<leader>sf", "<cmd>Telescope file_browser<cr>", { desc = "Browse files (telescope)" })
        vim.keymap.set("n", "<leader>sF", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "Browse current directory" })

        -- Content Search
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by grep (live)" })
        vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })

        -- Other
        vim.keymap.set("n", "<leader>uC", builtin.colorscheme, { desc = "Preview colorscheme" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })

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
