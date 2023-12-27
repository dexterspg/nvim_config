return {

    {
        'catppuccin/nvim',
        name ='catppuccin',
        lazy = false,
        priority = 1000,
        config = function() 
            vim.cmd('colorscheme catppuccin');

            require('catppuccin').setup({
                transparent_background=false,
                term_colors = false,
            })
        end
    },
    {
        'folke/tokyonight.nvim',
        lazy = true,
        -- config = function() vim.cmd('colorscheme tokyonight-moon') end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy =  false,
        -- priority = 1000,
        config = function()
            vim.cmd('colorscheme kanagawa') 
            vim.cmd('hi TelescopeBorder guibg=none') 
            vim.cmd('hi TelescopeTitle guibg=none') 
        end

    },

    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,

    },


}
