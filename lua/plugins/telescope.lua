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
        "echasnovski/mini.icons",
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        -- do not forget to install ripgrep ex. in cmd choco install ripgrep
        -- Keymaps for various Telescope pickers
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>pF", builtin.find_files, { desc = "[S]earch [F]iles cwd" })
        vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[F]ind [R]ecently [O]pen [F]iles" })
        vim.keymap.set("n", "<leader>uC", builtin.colorscheme, { desc = "Preview colorscheme" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
        vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Search string under cursor in cwd" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search open buffers" })

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

        -- Load the FZF native extension (optional but fast)
        pcall(telescope.load_extension, "fzf")
    end,
}
