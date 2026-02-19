local path_to_python = '/c/Python313/python.exe'

local function organize_imports()
    local params = {
        command = "pyright.organizeimports",
        arguments = { vim.uri_from_bufnr(0) },
    }
    vim.lsp.buf.execute(params)
end

return {
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
    },
    settings = {
        pyright = {
            disableLanguageService = false,
            disableOrganizeImports = false,
        },
        python = {
            pythonPath = path_to_python,
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
    commands = {
        PyrightOrganizeImports = {
            organize_imports,
            description = "Organize Imports",
        },
    },
}
