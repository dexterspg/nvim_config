vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.icons', opts ={} },
    opts={},
}
