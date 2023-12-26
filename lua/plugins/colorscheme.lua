return {

    {
        'folke/tokyonight.nvim',
        lazy = true,
        -- config = function() vim.cmd('colorscheme tokyonight-moon') end
    },
    {
        'rebelot/kanagawa.nvim',
        priority = 1000,
        config = function() vim.cmd('colorscheme kanagawa') end
    },

    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,

    },


}
