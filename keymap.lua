local opts = { noremap = true, silent = true }

keymap = vim.keymap.set
keymap("i", "jk", "<ESC>", opts)

-- keymap("n", "sj", "<C-w>j", opts)
-- keymap("n", "sl", "<C-w>l", opts)
-- keymap("n", "sk", "<C-w>k", opts)
-- keymap("n", "sh", "<C-w>h", opts)
