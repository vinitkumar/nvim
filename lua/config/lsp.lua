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

vim.lsp.config("ruby_lsp", {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".ruby-version", ".git" },
  init_options = {
    enabledFeatures = {
      "codeActions",
      "codeLens",
      "completion",
      "definition",
      "diagnostics",
      "documentHighlights",
      "documentLink",
      "documentSymbols",
      "foldingRanges",
      "formatting",
      "hover",
      "inlayHint",
      "onTypeFormatting",
      "selectionRanges",
      "semanticHighlighting",
      "signatureHelp",
      "workspaceSymbol",
    },
  },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- Resolve the opam-managed ocamllsp lazily. Shelling out to `opam var prefix`
-- at startup costs ~30-40ms even when we never open an OCaml file.
local ocamllsp_resolved = false
vim.api.nvim_create_autocmd("FileType", {
  group = lsp_group,
  pattern = { "ocaml", "ocamlinterface" },
  callback = function()
    if ocamllsp_resolved then
      return
    end
    ocamllsp_resolved = true

    local out = vim.fn.system("opam var prefix")
    if vim.v.shell_error ~= 0 then
      return
    end
    local prefix = (out or ""):gsub("%s+$", "")
    if prefix == "" then
      return
    end

    vim.lsp.config("ocamllsp", {
      cmd = { prefix .. "/bin/ocamllsp" },
      filetypes = { "ocaml", "ocamlinterface" },
      root_markers = { ".opam", "dune-project", ".git" },
    })
    vim.lsp.enable("ocamllsp")
  end,
})

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- ocamllsp is enabled lazily once the first OCaml buffer is opened.
vim.lsp.enable({ "ruby_lsp", "ts_ls", "lua_ls", "pyright" })
