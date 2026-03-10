return {
    'ahmedkhalf/project.nvim',
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup {
            active = true,
            on_config_done = nil,
            manual_mode = false,
            detection_methods = { "pattern" },
            patterns = { ".projectroot", ".git" },
            ignore_lsp = {},
            exclude_dirs = {},
            show_hidden = false,
            silent_chdir = true,
            scope_chdir = "global",
        }

        -- Function to create .projectroot in current directory
        local function create_projectroot()
            local current_dir = vim.fn.getcwd()
            local projectroot_path = current_dir .. "/.projectroot"

            -- Check if .projectroot already exists
            if vim.fn.filereadable(projectroot_path) == 1 then
                vim.notify("✓ .projectroot already exists in " .. current_dir, vim.log.levels.INFO)
                return
            end

            -- Create the file
            local file = io.open(projectroot_path, "w")
            if file then
                file:close()
                vim.notify("✓ Created .projectroot in " .. current_dir, vim.log.levels.INFO)

                -- Trigger project detection to pick up the new marker
                vim.cmd("cd " .. current_dir)
            else
                vim.notify("✗ Failed to create .projectroot", vim.log.levels.ERROR)
            end
        end

        -- Function to remove .projectroot from current directory
        local function remove_projectroot()
            local current_dir = vim.fn.getcwd()
            local projectroot_path = current_dir .. "/.projectroot"

            -- Check if .projectroot exists
            if vim.fn.filereadable(projectroot_path) == 0 then
                vim.notify("✗ No .projectroot found in " .. current_dir, vim.log.levels.WARN)
                return
            end

            -- Delete the file
            local success = os.remove(projectroot_path)
            if success then
                vim.notify("✓ Removed .projectroot from " .. current_dir, vim.log.levels.INFO)

                -- Trigger project detection to update
                vim.cmd("cd " .. current_dir)
            else
                vim.notify("✗ Failed to remove .projectroot", vim.log.levels.ERROR)
            end
        end

        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_set_keymap

        keymap("n", "<c-p>", ":lua require('telescope').extensions.projects.projects()<CR>", opts)

        -- Add .projectroot keymaps
        vim.keymap.set("n", "<leader>pr", create_projectroot, { desc = "Create .projectroot in current directory" })
        vim.keymap.set("n", "<leader>pR", remove_projectroot, { desc = "Remove .projectroot from current directory" })
    end,
}
