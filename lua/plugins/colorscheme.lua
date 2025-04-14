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
    --     config = function ()
    --         vim.cmd('colorscheme  solarized-osaka')
        -- end
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
        lazy = false,
        config = function()
            -- vim.cmd('colorscheme catppuccin');

            -- require('catppuccin').setup({
            -- transparent_background=true,
            -- term_colors = false,
            -- })
        end
    },
    {
        'folke/tokyonight.nvim',
        -- lazy = true,
        -- config = function() vim.cmd('colorscheme tokyonight') end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        config = function()
            -- vim.cmd('colorscheme kanagawa')
            -- vim.cmd('hi TelescopeBorder guibg=none')
            -- vim.cmd('hi TelescopeTitle guibg=none')
        end

    },

    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,

    },
    {
        'doki-theme/doki-theme-vim',
        lazy = true,
        config = function()
            -- vim.cmd('colorscheme katsuragi_misato')
        end

    }

}
