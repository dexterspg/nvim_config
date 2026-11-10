return {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
        { "<leader><leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
}
