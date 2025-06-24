return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'mfussenegger/nvim-jdtls',
        'hrsh7th/cmp-nvim-lsp',
        'folke/neodev.nvim',
    },
    config = function()
        local lspconfig = require("lspconfig")

        -- Ensure mason-lspconfig is properly loaded
        local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not mason_lspconfig_ok then
            vim.notify("mason-lspconfig not available in lsp.lua", vim.log.levels.ERROR)
            return
        end

        local capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )

        local path_to_python = vim.fn.expand('~') .. '/AppData/Local/Programs/Python/Python38-32/python.exe'
        local nvim_data = vim.fn.stdpath('data')
        local mason_path = nvim_data .. '/mason/bin'

        -- Optional: load your custom keymaps safely
        local success, keymaps = pcall(require, 'config.lsp.keymaps')
        if not success then
            print('Error: Failed to load keymaps.lua')
            return
        end
        local on_attach = function(_, bufnr)
            keymaps.map_lsp_keys({ buffer = bufnr })
        end

        --        Python
        local ok, pyright_config = pcall(require, 'config.lsp.pyright')
        if not ok then
            print('Error: Failed to load pyright.lua')
            return
        end

        lspconfig.pyright.setup({
            -- cmd = { mason_path .. "/pyright-langserver.cmd", "--stdio" },
            -- cmd = { "/pyright-langserver.cmd", "--stdio" },
            cmd = { "C:\\Users\\dexte\\AppData\\Roaming\\npm\\pyright-langserver.cmd", "--stdio" },
            -- cmd = { "pyright", "--stdio" },
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = pyright_config.default_config.root_dir,
            -- root_dir = function() return vim.loop.cwd() end,
            settings = pyright_config.default_config.settings
        })

        -- Load Neovim runtime for lua_ls
        require("neodev").setup()
        -- Lua
        vim.lsp.config['lua_ls'] = {
            cmd = { mason_path .. "/lua-language-server.cmd", "--stdio" },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },     -- ✅ let the server know 'vim' is a global
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        }


        -- TypeScript/JavaScript - ✅ FIXED: Changed from "tsserver" to "ts_ls"
        -- lspconfig.ts_ls.setup {
        --     cmd = { mason_path .. "/typescript-language-server.cmd", "--stdio" },
        --     filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
        --     root_dir = function() return vim.loop.cwd() end,
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        -- }
        --
        --        HTML
        vim.lsp.config.html = {
            cmd = { mason_path .. "/vscode-html-language-server.cmd", "--stdio" },
            filetypes = { "html", "htmldjango", "mason" },
            init_options = {
                configurationSection = { "html", "css", "javascript" },
                embeddedLanguages = {
                    css = true,
                    javascript = true
                },
            },
            root_dir = function() return vim.loop.cwd() end,
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- Vue
        -- lspconfig.volar.setup {
        --     cmd = { mason_path .. "/vue-language-server.cmd", "--stdio" },
        --     filetypes = { "javascript", "typescript", "vue" },
        --     root_dir = function() return vim.loop.cwd() end,
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        -- }


        vim.lsp.enable({
            'lua_ls',
            -- 'pyright',
            'html'
            -- 'ts_ls',
            -- 'html',
            -- 'volar'
        })
    end
}
