local M = {}
-- keymaps = P

--opts = { noremap = true, silent = true }

function M.map_lsp_keys(opts)
    --local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space><C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    -- Additional key mappings for diagnostics
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist) -- trouble vim used for entire workspace
end

function M.map_java_keys(opts)
    M.map_lsp_keys(opts)

    -- local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
    -- local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
    -- vim.keymap.set('n', '<leader>mm', command)

    vim.keymap.set('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
    vim.keymap.set('n', '<leader>jc', ':lua require("jdtls").compile("instrumental")')
    vim.keymap.set({ 'v', 'n' }, '<leader>cev', ':lua require("jdtls").extract_variable()<CR>', opts)
    vim.keymap.set({ 'v', 'n' }, '<leader>cec', ':lua require("jdtls").extract_constant()<CR>', opts)
    vim.keymap.set({ 'v', 'n' }, '<leader>cem', ':lua require("jdtls").extract_method()<CR>', opts)

    map_debug_keys()
    vim.keymap.set('n', '<F11>', run_spring_boot() )
    vim.keymap.set('n', '<C-F11>',  run_spring_boot(true) )
end

function map_debug_keys()
    vim.keymap.set('n', '<leader>da', ':lua attach_to_debug()<CR>')
    vim.keymap.set("n", "<leader>tm", function() run_java_test_method() end)
    vim.keymap.set("n", "<leader>TM", function() run_java_test_method(true) end)
    vim.keymap.set("n", "<leader>tc", function() run_java_test_class() end)
    vim.keymap.set("n", "<leader>TC", function() run_java_test_class(true) end)
    vim.keymap.set('n', 'gs', ':lua show_dap_centered_scopes()<CR>')

end

function run_spring_boot(debug)
    local spring_boot_runner=get_spring_boot_runner('local', debug)
    return ':lua require("toggleterm").exec([[' .. spring_boot_runner .. ']])<CR>'
end

function get_test_runner(test_name, debug)
    if debug then
        return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"' 
    end
    return 'mvn test -Dtest="' .. test_name .. '"' 
end

function run_java_test_method(debug)
    local utils = require'utils'
    local method_name = utils.get_current_full_method_name("\\#")
    vim.cmd('term ' .. get_test_runner(method_name, debug))
end

function run_java_test_class(debug)
    local utils = require'utils'
    local class_name = utils.get_current_full_class_name()
    vim.cmd('term ' .. get_test_runner(class_name, debug))
end

function get_spring_boot_runner(profile, debug)

    local debug_param = ""
    if debug then
        debug_param = '-Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"'
    end

    local profile_param = ""
    if profile then
        profile_param = "-Dspring-boot.run.profiles=" .. profile
    end
    return 'mvn spring-boot:run ' .. profile_param ..  ' ' .. debug_param

    -- local params = {}
    -- if #profile_param > 0 then
    --     table.insert(params, profile_param)
    -- end
    --
    -- if #debug_param > 0 then
    --     table.insert(params, debug_param)
    -- end
    -- return 'mvn spring-boot:run ' .. table.concat(params, ' ')
    --
end
function show_dap_centered_scopes()
      local widgets = require'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
end

function attach_to_debug()
    local dap = require('dap');
    dap.configurations.java = {
        {
            type = 'java';
            request = 'attach';
            name = "Attach to the process";
            hostName = 'localhost';
            port = '5005';
        },
    }
    dap.continue()
end



return M
