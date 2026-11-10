return {
    "selimacerbas/mdkite.nvim",
    dependencies = { "selimacerbas/kitehost.nvim" },
    ft = "markdown", -- Only load for markdown files
    cmd = "MdKite",
    opts = {},
    keys = {
        { "<leader>mps", "<cmd>MdKite start<cr>",   desc = "Markdown preview: start" },
        { "<leader>mpS", "<cmd>MdKite stop<cr>",    desc = "Markdown preview: stop" },
        { "<leader>mpr", "<cmd>MdKite refresh<cr>", desc = "Markdown preview: refresh" },
    },
}
