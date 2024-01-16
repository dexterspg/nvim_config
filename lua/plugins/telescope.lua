return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- TODO: fzf
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
        'BurntSushi/ripgrep',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[F]ind [R]ecently [O]pen [F]iles' })
        vim.keymap.set('n', '<leader>uC', builtin.colorscheme, { desc = 'Preview colorscheme' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find string in cwd' })
        vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Serach  string under cursor in cwd' })

        -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        -- vim.keymap.set('n', '<leader>ps', function()
        --     local input = vim.fn.input("Grep > ")
        --     if input ~= "" then
        --         builtin.grep_string({ search = input })
        --     else
        --         vim.api.nvim_echo({ { "No search word provided.", "WarningMsg" } }, true, {})
        --     end
        -- end)


        telescope.setup(
            {
                defaults = {
                    file_ignore_patterns = {
                        "^.git/", ".class", 'node_modules/*',
                    },
                    layout_strategy='vertical',
                },
                pickers = {
                    colorscheme = {
                        enable_preview = true
                    },
                    
                },
            })
        -- TODO: telescope fzf
        -- telescope.load_extension("fzf");
    end,

}
