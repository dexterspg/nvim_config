return {
    "rshkarin/mason-nvim-lint",
    dependencies = {
        "mfussenegger/nvim-lint",
        "mason-org/mason.nvim"
    },
    event = {
        "BufReadPre",
        "BufNewFile",
        "BufWritePost",
    },
    config = function()
        local lint = require("lint")
        local mason_linter = require("mason-nvim-lint")

        mason_linter.setup({
            ensure_installed = {
                -- "eslint_d",
                -- "prettier"
            },
            format = true
        })

        lint.linters_by_ft = {
             lua = {},
            javascript = {},
            typescript = {},
            vue = {},
            python = { "pylint" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("LintAutogroup", { clear = true })
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>gf", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
