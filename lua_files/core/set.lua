--vim.cmd[[colorscheme industry]] 
-- Map the leader key to spacebar
vim.g.mapleader = ' '
vim.g.maplocalleader=' '

-- Set options
vim.o.nu = true
vim.o.relativenumber = true


vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.smartindent = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.mouse= true
vim.o.guicursor= ""


vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. ".vim/undodir"

vim.o.wrap = false


vim.o.cursorline=true   -- not working

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- vim.opt.timeoutlen=100
-- Define register content
--vim.cmd('let @a = "iSystem.out.println("')  
--


local opts = { noremap = true, silent = true}

local function keymap(mode, shortcut, key)
	vim.keymap.set(mode, shortcut, key, opts)
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

-- Center cursor to middle of screen
keymap('n', '<C-d>','<C-d>zz')
keymap('n', '<C-u>','<C-u>zz')

-- Paste over visual not modified
keymap('x', '<leader>p','\"_dP')

--Move paragraph up and down
keymap('v', '<A-j>',":m '>+1<CR>gv=gv")
keymap('v', '<A-k>',":m '<-2<CR>gv=gv")


keymap({'n', 'v'}, '<leader>y',"\"+y")
keymap({'n', 'v'}, '<leader>Y',"\"+Y")

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

