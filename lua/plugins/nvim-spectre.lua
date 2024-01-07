return {
	'nvim-pack/nvim-spectre',
    dependencies={
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
    },
	cmd = "Spectre",
	-- config = function()
	-- 	local spectre = require('spectre');
	-- 	spectre.setup({
	-- 	})
	-- end,
	opts = { open_cmd = "noswapfile vnew" },
	keys = {
		{ "<leader><leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
	},
}

