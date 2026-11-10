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

        -- Find files by regex: Telescope's matcher is fuzzy (no real regex), so list files with
        -- ripgrep and filter them with a Vim regex typed in the prompt, e.g. tele.*lua or \.lua$
        -- (very-magic \v: plain ( ) | + ? work; all-lowercase = ignore case, any capital = match case)
        local function find_files_regex()
            local pickers = require("telescope.pickers")
            local finders = require("telescope.finders")
            local conf = require("telescope.config").values
            local sorters = require("telescope.sorters")
            local make_entry = require("telescope.make_entry")
            local files = vim.fn.systemlist({
                "rg", "--files", "--hidden",
                "--glob", "!.git", "--glob", "!**/node_modules/**", "--glob", "!*.class",
            })
            -- rg prints backslashes on Windows; use "/" so patterns like ^lua/plugins/ match
            for i, f in ipairs(files) do files[i] = f:gsub("\\", "/") end
            pickers.new({}, {
                prompt_title = "Find files (regex)",
                finder = finders.new_dynamic({
                    fn = function(prompt)
                        if not prompt or prompt == "" then return files end
                        local case = prompt:find("%u") and "\\C" or "\\c"
                        local ok, re = pcall(vim.regex, "\\v" .. case .. prompt)
                        if not ok then return {} end
                        local hits = {}
                        for _, f in ipairs(files) do
                            if re:match_str(f) then hits[#hits + 1] = f end
                        end
                        return hits
                    end,
                    entry_maker = make_entry.gen_from_file({}),
                }),
                previewer = conf.file_previewer({}),
                sorter = sorters.empty(), -- the regex already filtered the list
            }):find()
        end

        -- do not forget to install ripgrep ex. in cmd choco install ripgrep
        -- File/Buffer Navigation
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files (project root)" })
        vim.keymap.set("n", "<leader>fx", find_files_regex, { desc = "Find files (regex)" })
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
