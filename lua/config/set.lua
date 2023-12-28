local M = {}
function M.custom_keys()
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
--vim.o.undodir = os.getenv("HOME") .. ".vim/undodir"

vim.o.wrap = false


vim.o.cursorline=true   -- not working

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- vim.opt.timeoutlen=100
-- Define register content
--vim.cmd('let @a = "iSystem.out.println("')  
--
end

function M.mappings()
local opts = { noremap = true, silent = true}

keymap = vim.keymap 

-- Insert --
keymap.set('i','jk', "<ESC>", opts)

-- window navigation
--keymap.set('n', "<C-j>", "<C-w>j")
--keymap.set('n', "<C-l>", "<C-w>l")
--keymap.set('n', "<C-g>", "<C-w>h")
--keymap.set('n', "<C-k>", "<C-w>k")

-- Resize
keymap.set('n', "<C-Up>", ":resize +2<CR>", opts)
keymap.set('n', "<C-Down>", ":resize -2<CR>", opts)
keymap.set('n', "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set('n', "<C-Right>", ":vertical resize +2<CR>", opts)

-- navigate buffers
keymap.set('n', "<S-l>", ":bnext<CR>", opts)
keymap.set('n', "<S-h>", ":bprevious<CR>", opts)

--Move line up and down
keymap.set('n', '<A-k>','<esc>:m-2<CR>', opts)
keymap.set('n', '<A-j>','<esc>:m+1<CR>', opts)

-- Center cursor to middle of screen
keymap.set('n', '<C-d>','<C-d>zz', opts)
keymap.set('n', '<C-u>','<C-u>zz', opts)

-- Paste over visual not modified
keymap.set('x', '<leader>p','\"_dP', opts)

--Move paragraph up and down
keymap.set('v', '<A-j>',":m '>+1<CR>gv=gv", opts)
keymap.set('v', '<A-k>',":m '<-2<CR>gv=gv", opts)


keymap.set({'n', 'v'}, '<leader>y',"\"+y", opts)
keymap.set({'n', 'v'}, '<leader>Y',"\"+Y", opts)

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

keymap.set('n', '<leader>tp', '<cmd>lua toggle_paste()<cr>')
end

function M.start()
    M.custom_keys()
    M.mappings()
end

return M
