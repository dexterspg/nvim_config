return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

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
            -- lua_ls issue installation -> delete lua from mason/bin mason/share/mason-schema and mason/packages, then reinstall
            ensure_installed = { "jdtls", "html", "jsonls", "tsserver", "lua_ls", "volar", "cssls", "pyright" },
            automatic_installation = true,
        })
    end,
}
