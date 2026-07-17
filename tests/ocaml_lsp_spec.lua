vim.bo.filetype = "ocaml"

assert(package.loaded["config.lsp"] ~= nil, "expected LSP config to load for an OCaml buffer")
assert(vim.lsp.config.ocamllsp ~= nil, "expected ocamllsp to be configured for the first OCaml buffer")

vim.cmd("quitall!")
