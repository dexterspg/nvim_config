vim.env.PATH = table.concat({
  vim.env.PATH,
  "C:\\Users\\dexte\\AppData\\Roaming\\npm",
  "C:\\Program Files\\nodejs",
}, ";")

local function deduplicate_path(path_string)
  local seen = {}
  local result = {}
  for entry in string.gmatch(path_string, "[^;]+") do
    if not seen[entry] then
      table.insert(result, entry)
      seen[entry] = true
    end
  end
  return table.concat(result, ";")
end

vim.env.PATH = deduplicate_path(vim.env.PATH)
-- print(vim.env.PATH)

