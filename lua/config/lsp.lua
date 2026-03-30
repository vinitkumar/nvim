local lsp_group = vim.api.nvim_create_augroup("user_lsp", { clear = true })

vim.diagnostic.config({
  float = { border = "rounded" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.enable(true, { bufnr = args.buf, client_id = client.id })
    end

    if client:supports_method("textDocument/linkedEditingRange") then
      vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
    end
  end,
})

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
