return {
    "rshkarin/mason-nvim-lint",
    dependencies = {
        "mfussenegger/nvim-lint",
    },
    config = function()
        local nvim_lint = require("lint")
        local mason_linter = require("mason-nvim-lint")

        mason_linter.setup({
            ensure_installed ={'prettier', 'eslint_d' }
        })
        

    end,
}
