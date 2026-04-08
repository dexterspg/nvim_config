return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'mfussenegger/nvim-jdtls',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local nvim_data = vim.fn.stdpath('data')
        local mason_path = nvim_data .. '/mason/bin'

        -- Global capabilities from cmp-nvim-lsp (applies to all servers)
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        -- Keymaps via LspAttach autocmd (replaces on_attach)
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local opts = { buffer = args.buf }
                require('config.lsp.keymaps').map_lsp_keys(opts)
            end,
        })

        -- Python
        local basedpyright_config = require('config.lsp.basedpyright')
        vim.lsp.config('basedpyright', {
            cmd = { "cmd", "/c", mason_path .. "/basedpyright-langserver.cmd", "--stdio" },
            filetypes = basedpyright_config.default_config.filetypes,
            root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
            settings = basedpyright_config.default_config.settings,
            single_file_support = basedpyright_config.default_config.single_file_support,
        })

        -- Lua
        vim.lsp.config('lua_ls', {
            cmd = { mason_path .. "/lua-language-server.cmd", "--stdio" },
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = { vim.env.VIMRUNTIME },
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        })

        -- HTML
        vim.lsp.config('html', {
            cmd = { mason_path .. "/vscode-html-language-server.cmd", "--stdio" },
            filetypes = { "html", "htmldjango", "mason" },
            init_options = {
                configurationSection = { "html", "css", "javascript" },
                embeddedLanguages = {
                    css = true,
                    javascript = true
                },
            },
            root_markers = { "package.json", ".git" },
        })

        -- Markdown
        vim.lsp.config('marksman', {
            cmd = { mason_path .. "/marksman.cmd", "server" },
            filetypes = { "markdown", "markdown.mdx" },
            root_markers = { ".git", ".marksman.toml" },
        })

        vim.lsp.enable({
            'lua_ls',
            'marksman',
            'basedpyright',
            'html',
            -- 'ts_ls',
            -- 'volar',
        })
    end
}
