local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	local input =  vim.fn.input("Grep > ")
	if input ~= "" then
		builtin.grep_string({ search = input})
	else
		vim.api.nvim_echo({ { "No search word provided.", "WarningMsg" } }, true, {})
	end
	
end)

