return {
    "rshkarin/mason-nvim-lint",
    dependencies = {
        "mfussenegger/nvim-lint",
    },
    event = {
        "BufReadPre",
        "BufNewFile" },
    config = function()
        local lint = require("lint")
        local mason_linter = require("mason-nvim-lint")

        mason_linter.setup({
            ensure_installed = { 'prettier', 'eslint_d' }
        })

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
             vue        = { "eslint_d" }
        }
    end,
}
