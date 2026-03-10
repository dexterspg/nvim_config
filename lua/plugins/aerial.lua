return {
    'stevearc/aerial.nvim',
    dependencies = {
        "echasnovski/mini.icons",
    },
    keys = {
        { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Toggle Aerial (code outline)" },
        { "[o", "<cmd>AerialPrev<cr>", desc = "Previous symbol (outline)" },
        { "]o", "<cmd>AerialNext<cr>", desc = "Next symbol (outline)" },
    },
    opts = {
        backends = { "lsp", "treesitter" },
        layout = {
            width = 30,
            default_direction = "prefer_right",
            placement = "edge",
        },
        attach_mode = "global",
        filter_kind = {
            "Class",
            "Constructor",
            "Enum",
            "Function",
            "Interface",
            "Module",
            "Method",
            "Struct",
            "Field",
        },
        -- Auto-close aerial when you jump to a symbol
        close_on_select = false,
        -- Show symbol hierarchy
        show_guides = true,
        -- Icons for Java symbols
        icons = {
            Class = "",
            Constructor = "",
            Enum = "",
            Field = "",
            Function = "",
            Interface = "",
            Method = "",
            Module = "",
            Package = "",
        },
    },
}
