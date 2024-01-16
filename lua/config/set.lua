local M = {}
function M.custom_keys()
    -- Map the leader key to spacebar
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- Set options
    vim.opt.nu = true
    vim.opt.relativenumber = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
    vim.opt.splitbelow= true
    vim.opt.splitright= true

    vim.opt.smartindent = true
    vim.opt.smartcase = true
    vim.opt.ignorecase= true

    vim.opt.hlsearch = false
    vim.opt.incsearch = true

    vim.opt.mouse = "a"
    vim.opt.guicursor = ""
    vim.opt.termguicolors = true


    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.undofile = true
    vim.opt.undodir = os.getenv("HOME") .. ".vim/undodir"

    vim.opt.wrap = true

    --improve performance
    vim.opt.cursorline = false
    vim.opt.updatetime= 100
    vim.opt.timeoutlen=1000
    -- vim.opt.lazyredraw = true
    -- vim.opt.ttyfast = true

    vim.opt.completeopt = { "menuone", "noselect"}
    vim.opt.clipboard = "unnamedplus"
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- vim.opt.timeoutlen=100
    -- Define register content
    --vim.cmd('let @a = "iSystem.out.println("')

    -- let g:profstart=reltime() | for i in range(1,50) | exec "normal \<C-E>" | redraw | endfor | echo reltimestr(reltime(g:profstart)) . ' seconds'
end

function M.mappings()
    local opts = { noremap = true, silent = true }

    local keymap = vim.keymap

    --ESC
    keymap.set('i', 'jk', "<ESC>", opts)

    keymap.set('n', '00', "0w", opts)
    keymap.set('i', '<C-o>o', '<C-o>a', opts)

    keymap.set('n', '<leader>j', "5j", opts)
    keymap.set('n', '<leader>jj', "10j", opts)
    keymap.set('n', '<leader>k', "5k", opts)
    keymap.set('n', '<leader>kk', "10k", opts)


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
    keymap.set('n', '<A-k>', '<esc>:m-2<CR>', opts)
    keymap.set('n', '<A-j>', '<esc>:m+1<CR>', opts)

    -- Center cursor to middle of screen
    keymap.set('n', '<C-d>', '<C-d>zz', opts)
    keymap.set('n', '<C-u>', '<C-u>zz', opts)
    keymap.set('n', 'g;', "g;zz", opts)
    keymap.set('n', '#', "#zz", opts)
    keymap.set('n', '*', "*zz", opts)

    -- Paste over visual not modified
    keymap.set('x', 'p', [["_dP]])

    --Move paragraph up and down
    keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
    keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

    -- Indent block
    keymap.set('v','<', '<gv', opts)
    keymap.set('v','>', '>gv', opts)

    -- clipboard
    keymap.set({ 'n', 'v' }, '<leader>y', "\"+y", opts)
    keymap.set({ 'n', 'v' }, '<leader>Y', "\"+Y", opts)

    -- toggle paste
    _G.toggle_paste = function()
            vim.cmd('set nopaste')
        if vim.o.paste then
            print('Paste mode disabled')
        else
            vim.cmd('set paste')
            print('Paste mode enabled')
        end
    end

    keymap.set('n', '<leader>tp', '<cmd>lua toggle_paste()<cr>')
    keymap.set('n', '<leader>w', ':lua vim.wo.wrap= not vim.wo.wrap<CR>',opts)

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    --mouse click
    -- vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
    -- vim.cmd [[:amenu 10.110 mousemenu.References\ Definition <cmd>lua vim.lsp.buf.references()<CR>]]
    -- keymap.set('n', "<RightMouse>", "<cmd>:popup mousemenu<CR>")
    -- keymap.set('n', "<Tab>", "<cmd>:popup mousemenu<CR>")

end

function M.start()
    M.custom_keys()
    M.mappings()
end

return M
