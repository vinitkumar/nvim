if vim.loader then
  vim.loader.enable()
end

local modules = {
  "config.globals",
  "config.options",
  "config.lazy",
  "config.autocmds",
  "config.keymaps",
  "config.lsp",
}

for _, module in ipairs(modules) do
  require(module)
end
