local filetypes = {
  lua_ls = { "lua" },
  ocamllsp = { "ocaml", "ocamlinterface" },
  pyright = { "python" },
  ruby_lsp = { "ruby", "eruby" },
  ts_ls = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
}

local supported = {}
for _, server_filetypes in pairs(filetypes) do
  vim.list_extend(supported, server_filetypes)
end
table.sort(supported)

filetypes.supported = supported

return filetypes
