 
-- Map the leader key to spacebar
vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
-- Map the leader + n to toggle NERDTree
vim.keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>', {noremap = true})
vim.keymap.set('n', '<A-k>','<esc>:m-2<CR>', {noremap = true})
vim.keymap.set('n', '<A-j>','<esc>:m+1<CR>', {noremap = true})
vim.keymap.set('v', '<A-j>',":m '>+1<CR>gv=gv", {noremap = true})
vim.keymap.set('v', '<A-k>',":m '<-2<CR>gv=gv", {noremap = true})

vim.cmd('colorscheme industry')
-- Set options
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true  
-- vim.opt.timeoutlen=100
-- Define register content
vim.cmd('let @a = "iSystem.out.println("')  

