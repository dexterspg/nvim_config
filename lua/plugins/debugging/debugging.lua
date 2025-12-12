return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'rcarriga/cmp-dap',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        dapui.setup()

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

        -- Eclipse-style keymaps
        vim.keymap.set('n', '<F5>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F6>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F7>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<F8>', function() dap.continue() end, { desc = 'Debug: Resume/Continue' })
        vim.keymap.set('n', '<S-F8>', function() dap.terminate() end, { desc = 'Debug: Stop/Terminate' })

        -- Breakpoints
        vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Conditional Breakpoint' })

        -- Debug UI
        vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'Debug: Open REPL' })
        vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = 'Debug: Run Last' })
        vim.keymap.set('n', '<Leader>du', function() dapui.toggle() end, { desc = 'Debug: Toggle UI' })

        -- Hover to see variable value (like Eclipse)
        vim.keymap.set('n', 'K', function()
            local session = dap.session()
            if session and session.stopped_thread_id then
                require('dap.ui.widgets').hover()
            else
                vim.lsp.buf.hover()
            end
        end, { desc = 'Hover (debug or LSP)' })

        -- Dedicated debug hover (always uses DAP)
        vim.keymap.set('n', '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end, { desc = 'Debug: Hover Variable' })

        -- Evaluate expression (like Add Watch in Eclipse)
        vim.keymap.set('n', '<Leader>de', function() dapui.eval() end, { desc = 'Debug: Evaluate Expression' })
        vim.keymap.set('v', '<Leader>de', function() dapui.eval() end, { desc = 'Debug: Evaluate Selection' })

        -- Watch expression
        vim.keymap.set('n', '<Leader>dw', function()
            local expr = vim.fn.input('Watch expression: ')
            if expr ~= '' then
                require('dap.ui.widgets').hover(expr)
            end
        end, { desc = 'Debug: Watch Expression' })

        -- Java debug runner (compile and run with debugger) - Maven
        vim.keymap.set('n', '<Leader>jd', function()
            local root_dir = vim.fn.getcwd()
            local file = vim.fn.expand('%:t:r')
            local cmd = string.format(
                'cd "%s" && mvn compile && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005 -cp target/classes %s',
                root_dir, file
            )
            require("toggleterm").exec(cmd)
        end, { desc = 'Java: Run with Debugger (Maven)' })

        -- Java debug runner (simple javac)
        vim.keymap.set('n', '<Leader>jD', function()
            local root_dir = vim.fn.getcwd()
            local file = vim.fn.expand('%:t:r')
            local cmd = string.format(
                'cd "%s" && javac -g src/%s.java -d target/classes && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005 -cp target/classes %s',
                root_dir, file, file
            )
            require("toggleterm").exec(cmd)
        end, { desc = 'Java: Run with Debugger (javac)' })

        -- Java run (compile and run without debug)
        vim.keymap.set('n', '<Leader>jr', function()
            local root_dir = vim.fn.getcwd()
            local file = vim.fn.expand('%:t:r')
            local cmd = string.format(
                'cd "%s" && mvn compile exec:java -Dexec.mainClass="%s"',
                root_dir, file
            )
            require("toggleterm").exec(cmd)
        end, { desc = 'Java: Run (Maven)' })

        vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })

        vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })
        vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
        vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e4b2e' })
    end,
}
