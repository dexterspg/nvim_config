-- Skip this ftplugin for fugitive buffers (git diff, etc.)
if vim.bo.buftype == 'nofile' or vim.fn.expand('%'):match('^fugitive://') then
    return
end

-- Machine-specific JDK paths: auto-detect which one exists
local jdk_candidates = {
    "C:/Users/dpagkaliwangan/AppData/Local/Programs/Eclipse Adoptium/jdk-21.0.9.10-hotspot",
    "C:/Program Files/Amazon Corretto/jdk21.0.9_10",
}

local jdkPath21
for _, path in ipairs(jdk_candidates) do
    if vim.fn.isdirectory(path) == 1 then
        jdkPath21 = path
        break
    end
end

if not jdkPath21 then
    vim.notify("No JDK 21 found! Check jdk_candidates in ftplugin/java.lua", vim.log.levels.ERROR)
    return
end


-- vim.env.JAVA_HOME = jdkPath17
-- local nvim_data = 'C:/Users/dexte/AppData/Local/nvim-data'
local nvim_data = vim.fn.stdpath("data")
local mason_dir = nvim_data .. "/mason/packages"
local jdtls_dir = mason_dir .. "/jdtls"
local config_dir = jdtls_dir .. "/config_win"
local plugins_dir = jdtls_dir .. "/plugins"
local path_to_jar = vim.fn.glob(plugins_dir .. "/org.eclipse.equinox.launcher_*.jar")
local path_to_lombok = jdtls_dir .. "/lombok.jar"
local path_to_java_dap = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/"


vim.env.LOMBOK_JAR = path_to_lombok

local root_markers = { "pom.xml", ".git", "mvnw", "gradlew",  "build.gradle" }

_G._java_root_cache = _G._java_root_cache or {}

local function find_root_dir()
    local cwd = vim.fn.getcwd():gsub('\\', '/')
    if _G._java_root_cache[cwd] then
        return _G._java_root_cache[cwd]
    end

    local current_file = vim.fn.expand('%:p'):gsub('\\', '/')

    -- Find all pom.xml files walking up from current file
    local poms_found = {}
    local search_path = vim.fn.fnamemodify(current_file, ':h')

    while search_path and search_path ~= "/" and search_path ~= "C:/" do
        local pom_path = search_path .. "/pom.xml"
        if vim.fn.filereadable(pom_path) == 1 then
            table.insert(poms_found, { path = search_path, pom = pom_path })
        end
        local parent = vim.fn.fnamemodify(search_path, ':h')
        if parent == search_path then break end
        search_path = parent
    end

    local result
    if #poms_found == 0 then
        result = vim.fn.fnamemodify(current_file, ':h')
    elseif #poms_found == 1 then
        result = poms_found[1].path
    else
        -- Multiple poms: check if highest is a parent (multi-module project)
        local highest = poms_found[#poms_found]
        local ok, pom_content = pcall(function()
            return table.concat(vim.fn.readfile(highest.pom), "\n")
        end)
        if ok and pom_content:match("<modules>") then
            result = highest.path
        else
            result = poms_found[1].path
        end
    end

    _G._java_root_cache[cwd] = result
    return result
end



local root_dir = find_root_dir()

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

-- Check if project directory already exists
if vim.fn.isdirectory(workspace_dir) == 0 then
    vim.fn.mkdir(workspace_dir, "p")
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local success, keymaps = pcall(require, "config.lsp.keymaps")
if not success then
    vim.notify("Error: Failed to load keymaps.lua", vim.log.levels.ERROR)
    return
end

local on_attach = function(_, bufnr)
    keymaps.map_java_keys({ buffer = bufnr })
    require('jdtls').setup_dap({ hotcodereplace = 'auto'})
end
vim.cmd("lcd " .. root_dir)

local config = {
    cmd = {
        jdkPath21 .. "/bin/java.exe",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.level=ALL",
        "-javaagent:" .. tostring(vim.fn.getenv("LOMBOK_JAR")),
        "-Xmx2G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        path_to_jar,
        "-configuration",
        config_dir,
        "-data",
        workspace_dir,
    },

    root_dir = root_dir,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        java = {
            home = jdkPath21,
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = jdkPath21,
                    },

                    -- {
                    -- 	name = "JavaSE-17",
                    -- 	path = jdkPath17,
                    -- },
                    -- {
                        -- -- name = "JavaSE-11",
                        -- path = jdkPath11,
                    -- },
                },
            },
            autobuild = {
                enabled = false,
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
            inlayHints = {
                parameterNames = {
                    enabled = "all", -- literals, all, none
                },
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath("config"):gsub("\\","/") .. "/lang-servers/intellij-java-google-style.xml",
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
                "org",
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
        bundles = {
            vim.fn.glob(path_to_java_dap .. "/com.microsoft.java.debug.plugin-*.jar")
        },
    },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
        vim.schedule(function()
            pcall(vim.lsp.codelens.refresh)
        end)
    end,
})
require("jdtls").start_or_attach(config)
