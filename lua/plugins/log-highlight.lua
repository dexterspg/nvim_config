return {
    'fei6409/log-highlight.nvim',
    ft = "log",
    config = function()
        local log_highlight = require('log-highlight');
        log_highlight.setup{}
    end
}
