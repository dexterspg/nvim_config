return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'rcarriga/cmp-dap',
    },
    config = function()
        local dap = require('dap');
        local dapui = require('dapui');

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set('n', '<F8>', function() require('dap').continue() end)
        vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
        vim.keymap.set('n', '<F5>', function() require('dap').step_into() end)
        vim.keymap.set('n', '<F7>', function() require('dap').step_out() end)
        vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
        vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
        vim.keymap.set('n', '<Leader>lp',
            function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
        vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

        vim.fn.sign_define('DapBreakpoint', {text = '🟥', texthl = '', linehl = '', numhl = ''})
        vim.fn.sign_define('DapBreakpointRejected', {text = '🟦', texthl = '', linehl = '', numhl = ''})
        vim.fn.sign_define('DapStopped', {text = '⭐️', texthl = '', linehl = '', numhl = ''})
    end,
}
