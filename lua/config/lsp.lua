vim.lsp.config("sorbet", {
  cmd = { "srb", "tc", "--lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
})
vim.lsp.enable("sorbet")

local opam_switch_prefix = vim.fn.system("opam var prefix"):gsub("\n", "")
local ocamllsp_bin = opam_switch_prefix .. "/bin/ocamllsp"

vim.lsp.config("ocamllsp", {
  cmd = { ocamllsp_bin },
  filetypes = { "ocaml", "ocamlinterface" },
  root_markers = { ".opam", "dune-project", ".git" },
})
vim.lsp.enable("ocamllsp")
