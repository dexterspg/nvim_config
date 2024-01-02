local javaPath = 'C:/Program Files/Java'
local jdkPath17 = javaPath .. '/jdk-17'
local jdkPath11 = javaPath .. '/jdk-11.0.7'
-- vim.env.JAVA_HOME = jdkPath17
-- local nvim_data = 'C:/Users/dexte/AppData/Local/nvim-data'
local nvim_data = vim.fn.stdpath('data')
local mason_dir = nvim_data .. '/mason/packages'
local jdtls_dir = mason_dir .. '/jdtls'
local config_dir = jdtls_dir .. '/config_win'
local plugins_dir = jdtls_dir .. '/plugins'
local path_to_jar = plugins_dir .. '/org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar'
local path_to_lombok = jdtls_dir .. '/lombok.jar'
vim.env.LOMBOK_JAR = path_to_lombok

local root_markers = { '.git', 'mvnw', 'gradlew', "pom.xml", "build.gradle" }
-- local root_dir = require('jdtls.setup').find_root(root_markers)

local function find_root_dir()
    local current_dir = vim.fn.getcwd()
    for _, marker in ipairs(root_markers) do
        local root_dir = require('lspconfig').util.root_pattern(marker)(current_dir)
        if root_dir and root_dir ~= '' then
            return root_dir
        end
    end
    return current_dir
end

local root_dir = find_root_dir()
-- print("root_dir: " .. root_dir)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute("mkdir " .. workspace_dir)

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.cmd('cd ' .. vim.fn.stdpath('config'))
local success, keymaps = pcall(require, 'config.lsp.keymaps')
if not success then
    print('Error: Failed to load keymaps.lua, keymaps')
    return
end

local on_attach = function(_, bufnr)
    keymaps.map_java_keys({ buffer = bufnr })
end
vim.cmd('cd ' .. root_dir)

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.level=ALL',
        '-javaagent:' .. tostring(vim.fn.getenv('LOMBOK_JAR')),
        '-Xmx2G',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', path_to_jar,
        '-configuration', config_dir,
        '-data', workspace_dir

    },

    root_dir = root_dir,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        java = {
            home = jdkPath17,
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = jdkPath17,
                    },
                    {
                        name = "JavaSE-11",
                        path = jdkPath11,
                    },
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },

        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org"
            },
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },

    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = {},
    },
}


require('jdtls').start_or_attach(config)
