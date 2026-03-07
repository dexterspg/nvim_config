return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    config = function()
        local noice = require("noice")
        noice.setup({
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        find = "Query error at",
                    },
                    opts = { skip = true },
                },
            },
        })

    end


}
