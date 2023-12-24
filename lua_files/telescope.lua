local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
         file_ignore_patterns = {
            ".git/*", ".class", 'node_modules/*',
        }
    },
});
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[S]earch [F]iles'})
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[F]ind [R]ecently [O]pen [F]iles'})


-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	local input =  vim.fn.input("Grep > ")
	if input ~= "" then
		builtin.grep_string({ search = input})
	else
		vim.api.nvim_echo({ { "No search word provided.", "WarningMsg" } }, true, {})
	end
end)

