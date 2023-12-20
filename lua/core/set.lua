--vim.cmd[[colorscheme industry]] 
-- Map the leader key to spacebar
vim.g.mapleader = ' '
vim.g.maplocalleader=' '

-- Set options
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.hlsearch = true
vim.o.mouse= true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.wrap = true
vim.o.cursorline=true   -- not working

-- vim.opt.timeoutlen=100
-- Define register content
--vim.cmd('let @a = "iSystem.out.println("')  
--


local opts = { noremap = true, silent = true}

function keymap(mode, shortcut, key)
	vim.api.nvim_set_keymap(mode, shortcut, key, opts)
end
-- Use netrw
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Insert --
keymap('i','jk', "<ESC>")

-- window navigation
--keymap('n', "<C-j>", "<C-w>j")
--keymap('n', "<C-l>", "<C-w>l")
--keymap('n', "<C-g>", "<C-w>h")
--keymap('n', "<C-k>", "<C-w>k")

-- Resize
keymap('n', "<C-Up>", ":resize +2<CR>")
keymap('n', "<C-Down>", ":resize -2<CR>")
keymap('n', "<C-Left>", ":vertical resize -2<CR>")
keymap('n', "<C-Right>", ":vertical resize +2<CR>")

-- navigate buffers
keymap('n', "<S-l>", ":bnext<CR>")
keymap('n', "<S-h>", ":bprevious<CR>")

--Move line up and down
keymap('n', '<A-k>','<esc>:m-2<CR>')
keymap('n', '<A-j>','<esc>:m+1<CR>')

--Move paragraph up and down
keymap('v', '<A-j>',":m '>+1<CR>gv=gv")
keymap('v', '<A-k>',":m '<-2<CR>gv=gv")


-- toggle paste
_G.toggle_paste = function ()
  if vim.o.paste then
	    vim.cmd('set nopaste')
    print('Paste mode disabled')
  else
    vim.cmd('set paste')
    print('Paste mode enabled')
  end
end
keymap('n', '<leader>tp', '<cmd>lua toggle_paste()<cr>')
