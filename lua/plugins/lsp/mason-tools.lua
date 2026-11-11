-- Installs the formatters and linters (not language servers) that conform and nvim-lint call.
-- Language servers are installed by mason-lspconfig's ensure_installed in mason.lua.
return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    -- No `event`: the plugin checks for missing tools on VimEnter, so it must load at startup
    opts = {
        ensure_installed = {
            "black",     -- Python formatter
            "prettierd", -- JS / TS / JSON / Vue / CSS formatter
            "pylint",    -- Python linter
        },
    },
}
