return {
    {
        "nickkadutskyi/jb.nvim",
        lazy = true,
        priority = 1000,
        opts = function()
            return {
                transparent = true,
            }
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        priority = 1000,
        opts = function()
            return {
                transparent = true,
            }
        end,
        --     config = function ()
        --         vim.cmd('colorscheme  solarized-osaka')
        -- end
    },

    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true,
        priority = 1000,
        opts = function()
            return {
                transparent = true,
            }
        end,
        --     config = function ()
        --         vim.cmd('colorscheme  solarized-osaka')
        -- end
    },

    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
        -- vim.cmd('colorscheme catppuccin')
    },
    {
        'folke/tokyonight.nvim',
        lazy = true,
        -- config = function() vim.cmd('colorscheme tokyonight') end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        config = function(colors)
            require('kanagawa').setup({
                transparent = true,
                overrides = function(colors)
                    return {
                        ["@markup.link.url.markdown_inline"] = { link = "Special" },
                        ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
                        ["@markup.italic.markdown_inline"] = { link = "Exception" },
                        ["@markup.raw.markdown_inline"] = { link = "String" },
                        ["@markup.list.markdown"] = { link = "Function" },
                        ["@markup.quote.markdown"] = { link = "Error" },
                    }
                end
            })
        end,
    },

    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,

    },
    {
        'doki-theme/doki-theme-vim',
        lazy = true,
        -- vim.cmd('colorscheme katsuragi_misato')
    }

}
