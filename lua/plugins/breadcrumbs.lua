return {
    'LunarVim/breadcrumbs.nvim',
    dependencies = {
        {
            "SmiteshP/nvim-navic",
            opts = { lsp = { auto_attach = true } },
        },
    },
    config = function()
        local breadcrumbs = require('breadcrumbs');
        breadcrumbs.setup()
    end,
}
