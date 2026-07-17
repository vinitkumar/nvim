vim.g.config_start_time_ns = vim.uv.hrtime()

if vim.loader then
  vim.loader.enable()
end

local modules = {
  "config.globals",
  "config.options",
  "config.lazy",
  "config.autocmds",
  "config.keymaps",
}

for _, module in ipairs(modules) do
  require(module)
end

local lsp_filetypes = require("config.lsp_filetypes")

vim.api.nvim_create_autocmd("FileType", {
  pattern = lsp_filetypes.supported,
  once = true,
  callback = function()
    require("config.lsp")
  end,
})
