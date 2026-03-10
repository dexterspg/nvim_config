local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local plugins = {
    spec = {
        { import = 'plugins' },
        { import = 'plugins.git-helper' },
        { import = 'plugins.lsp' },
        { import = 'plugins.formatting' },
        { import = 'plugins.debugging' },
        { import = 'plugins.assistant.codeium' },
        -- { import = 'plugins.assistant.avante' },
        -- { import = 'plugins.leetcode' },
    },
    install = {},
    checker = { enabled = true, notify = false, frequency = 86400 },
}
local opts = {}
require("lazy").setup(plugins, opts)
