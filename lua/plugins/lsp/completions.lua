return {
	'hrsh7th/nvim-cmp',
    -- event = { "BufReadPre", "BufNewFile"},
    dependencies ={
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
	{ 'L3MON4D3/LuaSnip', version = "v2.*" },
	'rafamadriz/friendly-snippets',
	'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local ls = require('luasnip')
        local cmp = require('cmp')

        vim.g.snippets_dir = "snippets"
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        -- local cmp_select = { behavior = cmp.SelectBehavior.Select, select = true }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                --      ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                --    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.SelectBehavior.Select,
                    select = true
                }),
                ["<leader><Tab>"] = function()
                    cmp.mapping.confirm()
                    ls.expand_or_jump()
                end,
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif ls.expand_or_jumpable() then
                        ls.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif ls.expand_or_jumpable(-1) then
                        ls.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                --{ name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.keymap.set({ "i" }, "<C-k>", function() ls.expand() end, { silent = true })
        --vim.keymap.set({ "i", "s" }, "<C-n>", function() ls.expand_or_jump(1) end, { silent = true })
        --vim.keymap.set({ "i", "s" }, "<C-p>", function() ls.jump(-1) end, { silent = true })
    end
}
