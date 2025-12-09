return {
    'akinsho/toggleterm.nvim',
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<C-\>]],
            start_in_insert = true,
            direction = 'float',
            close_on_exit = true
            --shell = vim.o.shell

        })

        vim.cmd [[let &shell = '"C:\\Program Files\\Git\\bin\\bash.exe"']]
        vim.cmd [[let &shellcmdflag = '-s']]
    end
}
