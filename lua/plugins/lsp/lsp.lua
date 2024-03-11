return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'mfussenegger/nvim-jdtls',
        'hrsh7th/cmp-nvim-lsp',
        'folke/neodev.nvim',
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local path_to_python = vim.fn.expand('~') .. '/AppData/Local/Programs/Python/Python38-32/python.exe'
        -- local path_to_lua = 'C:/Program Files (x86)/Lua/5.1/lua.exe'
        local nvim_data = vim.fn.stdpath('data')
        local mason_path = nvim_data .. '/mason/bin'

        local success, keymaps = pcall(require, 'config.lsp.keymaps')
        if not success then
            print('Error: Failed to load keymaps.lua, keymaps')
            return
        end

        local on_attach = function(_, bufnr) keymaps.map_lsp_keys({ buffer = bufnr }) end

        lspconfig.tsserver.setup {
            cmd = { mason_path .. "/typescript-language-server.cmd", "--stdio" },
            filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
            root_dir = function() return vim.loop.cwd() end,
            on_attach = on_attach,
            capabilities = capabilities
        }


        lspconfig.html.setup {
            cmd = { mason_path .. "/vscode-html-language-server.cmd", "--stdio" },
            filetypes = { "html", "htmldjango", "mason" },
            init_options = {
                configurationSection = { "html", "css", "javascript" },
                embeddedLanguages = {
                    css = true,
                    javascript = true
                },
            },

            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function() return vim.loop.cwd() end,
        }

        -- lspconfig.pyright.setup {
        --     cmd = { mason_path .. "/pyright-langserver.cmd", "--stdio" },
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --
        --     root_dir = function() return vim.loop.cwd() end,
        --     settings = {
        --         python = {
        --             pythonPath = path_to_python
        --         }
        --     }
        -- }
        
        local success, pyright_config = pcall(require, 'config.lsp.pyright')
        if not success then
            print('Error: Failed to load pyright.lua')
            return
        end

        lspconfig.pyright.setup {
            cmd = { mason_path .. "/pyright-langserver.cmd", "--stdio" },
            on_attach = on_attach,
            capabilities = capabilities,

            -- root_dir = function() return vim.loop.cwd() end,
            root_dir = pyright_config.default_config.root_dir,
            settings = pyright_config.default_config.settings.python
        }


        lspconfig.volar.setup {
            cmd = { mason_path .. "/vue-language-server.cmd", "--stdio" },
            filetypes= { "javascript","typescript", "vue" },
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function() return vim.loop.cwd() end,

        }

        require("neodev").setup()
        lspconfig.lua_ls.setup {
            cmd          = { mason_path .. "/lua-language-server.cmd", "--stdio" },
            filetypes    = { "lua" },
            on_attach    = on_attach,
            capabilities = capabilities,
            root_dir     = function() return vim.loop.cwd() end,
            settings     = {
                Lua = {
                    runtime = {
                        version = 'luaJIT'
                    },
                    diagnostics = {
                        globals = { 'vim' }
                    },
                }
            }
        }
    end
}
