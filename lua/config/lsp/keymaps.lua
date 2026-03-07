local M = {}
-- keymaps = P
--opts = { noremap = true, silent = true }

function M.map_lsp_keys(opts)
    --local opts = { buffer = bufnr }
    -- Basic LSP Navigation
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

    -- LSP Actions
    vim.keymap.set('n', '<space><C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    -- Workspace Management
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- Telescope LSP Pickers (fuzzy searchable symbol navigation)
    vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', { desc = "Find symbols (current file)" })
    vim.keymap.set('n', '<leader>fS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', { desc = "Find symbols (workspace)" })
    vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', { desc = "Find references" })
    vim.keymap.set('n', '<leader>fi', '<cmd>Telescope lsp_implementations<cr>', { desc = "Find implementations" })
    vim.keymap.set('n', '<leader>fd', '<cmd>Telescope lsp_definitions<cr>', { desc = "Find definitions" })

    -- Diagnostics
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Next diagnostic" })
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Previous diagnostic" })
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist) -- trouble vim used for entire workspace
end

function M.rename_java_file(opts)
    local filepath = vim.fn.expand("%:p")
    local new_filename = vim.fn.input("New filename: ", filepath)

    if new_filename ~= "" and new_filename ~= filepath then
        vim.fn.rename(filepath, new_filename)
        vim.api.nvim_buf_set_name(opts, new_filename)

        -- Call Java LSP rename to update class name
        require("jdtls").organize_imports()
        vim.lsp.buf.rename()
    end

    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua rename_java_file()<CR>", { noremap = true, silent = true })
end

function M.map_java_keys(opts)
    M.map_lsp_keys(opts)
    -- M.rename_java_file(opts)

    -- local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
    -- local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
    -- vim.keymap.set('n', '<leader>mm', command)

    vim.keymap.set("n", "<leader>rj", rename_java_file, {
        desc = "Rename Java file",
        noremap = true,
        silent = true,
        buffer = 0, -- or specify a buffer number if needed
    })
    vim.keymap.set('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
    vim.keymap.set('n', '<leader>jc', ':lua require("jdtls").compile("instrumental")')
    vim.keymap.set({ 'v', 'n' }, '<leader>cev', ':lua require("jdtls").extract_variable()<CR>', opts)
    vim.keymap.set({ 'v', 'n' }, '<leader>cec', ':lua require("jdtls").extract_constant()<CR>', opts)
    vim.keymap.set({ 'v', 'n' }, '<leader>cem', ':lua require("jdtls").extract_method()<CR>', opts)
    vim.keymap.set({ 'v', 'n' }, '<leader>csm', ':lua vim.lsp.buf.document_symbol()<CR>', opts)

    map_debug_keys()
    -- FIXME: Missing utils module - uncomment when utils.lua is created
    -- vim.keymap.set('n', '<F11>', run_spring_boot())
    -- vim.keymap.set('n', '<C-F11>', run_spring_boot(true))
end

function rename_java_file()
    local current_name = vim.fn.expand("%:t:r") -- current file name without extension

    vim.ui.input({ prompt = "New class name: ", default = current_name }, function(new_name)
        if not new_name or #new_name == 0 or new_name == current_name then
            return
        end

        local params = vim.lsp.util.make_position_params()
        params.newName = new_name

        -- Request LSP rename with callback - wait for it to complete!
        vim.lsp.buf_request(0, "textDocument/rename", params, function(err, result, ctx, config)
            if err then
                vim.notify("LSP rename error: " .. tostring(err), vim.log.levels.ERROR)
                return
            end

            -- Apply the workspace edit from LSP (renames class in all files)
            if result then
                vim.lsp.util.apply_workspace_edit(result, "utf-8")
            end

            -- Wait for edits to be applied to buffer before renaming file
            vim.defer_fn(function()
                local old_file = vim.api.nvim_buf_get_name(0)
                local old_file_name = vim.fn.fnamemodify(old_file, ":t:r")
                local dir = vim.fn.fnamemodify(old_file, ":h")
                local new_file = dir .. "/" .. new_name .. ".java"

                -- Use vim.uv.fs_rename for better error handling
                local success, rename_err = pcall(function()
                    vim.uv.fs_rename(old_file, new_file)
                end)

                if not success then
                    vim.notify("File rename error: " .. tostring(rename_err), vim.log.levels.ERROR)
                    return
                end

                -- Open the renamed file and close the old buffer
                vim.cmd("edit " .. vim.fn.fnameescape(new_file))
                vim.cmd("bdelete! " .. vim.fn.fnameescape(old_file))
                vim.notify("✓ Renamed " .. old_file_name .. " → " .. new_name, vim.log.levels.INFO)
            end, 500)  -- Wait 500ms for edits to apply
        end)
    end)
end

function map_debug_keys()
    vim.keymap.set('n', '<leader>da', ':lua attach_to_debug()<CR>')
    -- FIXME: Missing utils module - uncomment when utils.lua with get_current_full_method_name/get_current_full_class_name is created
    -- vim.keymap.set("n", "<leader>tm", function() run_java_test_method() end)
    -- vim.keymap.set("n", "<leader>TM", function() run_java_test_method(true) end)
    -- vim.keymap.set("n", "<leader>tc", function() run_java_test_class() end)
    -- vim.keymap.set("n", "<leader>TC", function() run_java_test_class(true) end)
    vim.keymap.set('n', 'gs', ':lua show_dap_centered_scopes()<CR>')
end

-- FIXME: Missing utils module - uncomment when utils.lua is created
-- function run_spring_boot(debug)
--     local spring_boot_runner = get_spring_boot_runner('local', debug)
--     return ':lua require("toggleterm").exec([[' .. spring_boot_runner .. ']])<CR>'
-- end

function run_mvn()
    -- TODO: run in togglet term 'mvn clean install exec:java' without changing the exec-maven-plugin with the class containing the main method
    -- local spring_boot_runner=get_spring_boot_runner('local', debug)
    -- return ':lua require("toggleterm").exec([[mvn clean install ' .. spring_boot_runner .. ']])<CR>'
end

function get_test_runner(test_name, debug)
    if debug then
        return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
    end
    return 'mvn test -Dtest="' .. test_name .. '"'
end

-- FIXME: Missing utils module - uncomment when utils.lua is created
-- function run_java_test_method(debug)
--     local utils = require 'utils'
--     local method_name = utils.get_current_full_method_name("\\#")
--     vim.cmd('term ' .. get_test_runner(method_name, debug))
-- end
--
-- function run_java_test_class(debug)
--     local utils = require 'utils'
--     local class_name = utils.get_current_full_class_name()
--     vim.cmd('term ' .. get_test_runner(class_name, debug))
-- end

function get_spring_boot_runner(profile, debug)
    local debug_param = ""
    if debug then
        debug_param =
        '-Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"'
    end

    local profile_param = ""
    if profile then
        profile_param = "-Dspring-boot.run.profiles=" .. profile
    end
    return 'mvn spring-boot:run ' .. profile_param .. ' ' .. debug_param

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
    local widgets = require 'dap.ui.widgets'
    widgets.centered_float(widgets.scopes)
end

function attach_to_debug()
    local dap = require('dap');
    dap.configurations.java = {
        {
            type = 'java',
            request = 'attach',
            name = "Attach to the process",
            hostName = 'localhost',
            port = '5005',
        },
    }
    dap.continue()
end

return M
