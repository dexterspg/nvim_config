return {
    'mason-org/mason.nvim',
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
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
                "lua_ls",
                "marksman",  -- Markdown LSP (enables gd for links)
                -- "html-lsp",
                -- "jsonls",
                -- "ts_ls",
                -- "cssls",
                -- "basedpyright",
            },
            automatic_enable = {
                exclude = { "jdtls" },
            },
        })
    end,
}
