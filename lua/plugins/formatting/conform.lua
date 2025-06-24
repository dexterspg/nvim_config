return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = {
                    "prettierd",
                    "prettier",
                    stop_after_first = true,
                },
                typescript = {
                    "prettierd",
                    "prettier",
                    stop_after_first = true,
                },
                json = {
                    "prettierd",
                    "prettier",
                    stop_after_first = true,
                },
                vue = {
                    "prettierd",
                    "prettier",
                    stop_after_first = true,
                },
                python = { "black" },
                html = { "htmlbeautifier" },
                css = {
                    "prettierd",
                    "prettier",
                    stop_after_first = true,
                },
                scss = {
                    "prettierd",
                    "prettier",
                    stop_after_first = true,
                },
            }
        })

        vim.keymap.set({ "n", "v" }, "<leader>ll", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 2000,
            })
            require("lint").try_lint()
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
