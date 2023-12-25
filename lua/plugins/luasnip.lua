return {
  "l3mon4d3/LuaSnip",
  keys = function()
    return {}
  end,
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets/",
    })
  end,
}
