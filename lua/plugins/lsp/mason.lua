return {
    'mason-org/mason.nvim',
    dependencies = {
        {
            'mason-org/mason-lspconfig.nvim',
        },
    },
    config = function()
        local mason = require("mason")

        local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not mason_lspconfig_ok then
            vim.notify("mason-lspconfig not available (mason.lua)", vim.log.levels.ERROR)
            return
        end

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "jdtls",
                -- "html-lsp",
                -- "jsonls",
                -- "ts_ls",
                "lua_ls",
                -- "cssls",
                -- "basedpyright",
            },
            automatic_enable = true,
        })
    end,
}
