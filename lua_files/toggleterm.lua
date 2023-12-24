require("toggleterm").setup({
  size = 20,
  open_mapping=[[<C-\>]],
  start_in_insert=true,
  direction = 'float',  
  close_on_exit=true
  --shell = vim.o.shell

})


vim.cmd [[let &shell = '"C:\\Program Files\\Git\\bin\\bash.exe"']]
vim.cmd [[let &shellcmdflag = '-s']]

--vim.api.nvim_set_keymap('n', '<leader>t', ':term C:\\Program^ Files\\Git\\bin\\bash.exe<CR>', { noremap = true, silent = true })

--Make the terminal behave like a normal buffer
--vim.cmd([[ autocmd TermOpen * startinsert ]])

