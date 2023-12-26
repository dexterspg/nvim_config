return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local ok, npairs = pcall(require, 'nvim-autopairs')
        if not ok then return end

        npairs.setup({
            check_ts = true,
            ts_config = {
                lua = { 'string', 'source' }, -- it will not add a pair on that treesitter node
                javascript = { 'string', 'template_string' },
                java = false, -- don't check treesitter on java
            },
            disable_filetype = {},
            fast_wrap = {
                map = '<M-e>',
                chars = { '{', '[', '(', '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                offset = 0,
                end_key = '$',
                -- before_key = 'h',
                -- after_key = 'l',
                cursor_pos_before = true,
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                --  manual_position = true,
                check_comma = true,
                highlight = 'PmenuSel',
                highlight_grey = 'LineNr'
            },
        })
    end
}

