local util = require("lspconfig.util")
local path_to_python = "/c/Python313/python.exe"
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
local bin_name = mason_bin .. "/basedpyright-langserver.cmd"
local cmd = { bin_name, "--stdio" }

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
}

local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute(params)
end

return {
  default_config = {
    -- cmd = cmd,
    filetypes = { "python" },
    root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname)
        or (function()
          local git_root = vim.fs.find('.git', { path = fname, upward = true })[1]
          return git_root and vim.fs.dirname(git_root) or nil
            end)()
        or vim.fn.getcwd()
    end,
    single_file_support = true,
    settings = {
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
  },
  commands = {
    BasedPyrightOrganizeImports = {
      organize_imports,
      description = "Organize Imports with BasedPyright",
    },
  },
  docs = {
    description = [[
https://github.com/basedpyright/basedpyright
`basedpyright`, a community-maintained fork of `pyright` with new features and faster release cadence.
]],
  },
}

