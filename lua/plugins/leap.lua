return {
	'ggandor/leap.nvim',
    dependencies = {
        'tpope/vim-repeat',
    },
	config = function()
		local leap = require('leap');
    	 -- leap.create_default_mappings()
     	vim.api.nvim_set_keymap('n', '<leader>s', "<Plug>(leap-forward)", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>S', "<Plug>(leap-backward>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>gs', "<Plug>(leap-from-window>", { noremap = true, silent = true })
	end,
}
