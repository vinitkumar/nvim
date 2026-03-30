local keymap = vim.keymap
local is_linux = vim.uv.os_uname().sysname == "Linux"

local function has_native_lsp(bufnr)
  return #vim.lsp.get_clients({ bufnr = bufnr or 0 }) > 0
end

local function jump_to_location(method, coc_fallback)
  return function()
    if has_native_lsp(0) then
      vim.lsp.buf[method]()
      return
    end

    vim.api.nvim_feedkeys(vim.keycode(coc_fallback), "m", false)
  end
end

local function show_diagnostics()
  if has_native_lsp(0) then
    vim.diagnostic.setloclist({ open = true })
    return
  end

  vim.cmd("CocDiagnostics")
end

if is_linux then
  keymap.set("n", "<C-p>", function() require("fzf-lua").files() end, { desc = "Find files" })
  keymap.set("n", "<C-b>", function() require("fzf-lua").buffers() end, { desc = "Find buffers" })
  keymap.set("n", "<C-h>", function() require("fzf-lua").git_files() end, { desc = "Find Git files" })
else
  keymap.set("n", "<C-p>", function() require("fff").find_files() end, { desc = "Find files" })
  keymap.set("n", "<C-b>", function() require("fff").buffers() end, { desc = "Find buffers" })
  keymap.set("n", "<C-h>", function() require("fff").git_files() end, { desc = "Find Git files" })
end

keymap.set("n", "<C-c>", ":NvimTreeToggle<CR>")
keymap.set("n", "<C-t>", ":tabNext<CR>")
keymap.set("n", "<C-e>", show_diagnostics, { desc = "Buffer diagnostics" })
keymap.set("n", "<C-s>", ":GFiles<CR>")
keymap.set("n", "<C-g>", ":LazyGit<CR>")
keymap.set("n", "<leader>gd", jump_to_location("definition", "<Plug>(coc-definition)"), { desc = "Go to definition" })
keymap.set("n", "<leader>gy", jump_to_location("type_definition", "<Plug>(coc-type-definition)"), { desc = "Go to type definition" })
keymap.set("n", "<leader>gr", jump_to_location("references", "<Plug>(coc-references)"), { desc = "Go to references" })
keymap.set("n", "<leader>gi", jump_to_location("implementation", "<Plug>(coc-implementation)"), { desc = "Go to implementation" })
keymap.set("n", "<leader>h", ":<C-u>split<CR>")
keymap.set("n", "<leader>z", ":<C-u>Goyo<CR>")
keymap.set("n", "<leader>v", ":<C-u>vsplit<CR>")
keymap.set("n", "<leader>t", ":<C-u>tabnew<CR>")
keymap.set("n", "<leader>dt", 'i<C-r>=strftime("%c")<CR>', { noremap = true, silent = true })
keymap.set("n", "<leader>lw", function() vim.lsp.buf.workspace_diagnostics() end, { desc = "Workspace diagnostics" })
keymap.set("n", "<leader>lr", function() vim.cmd("lsp restart") end, { desc = "Restart LSP" })
keymap.set("n", "grx", function() vim.lsp.codelens.run() end, { desc = "Run code lens" })

keymap.set("n", "<CR>", "G")
keymap.set("n", "<BS>", "gg")
keymap.set("n", "<j>", "gj")
keymap.set("n", "<k>", "gk")

local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

keymap.set("i", "<Tab>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#next"](1)
  end
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  if check_back_space() then
    if has_native_lsp(0) then
      return "<C-x><C-o>"
    end
    return vim.fn["coc#refresh"]()
  end
  return "<Tab>"
end, opts)

keymap.set("i", "<S-Tab>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#prev"](1)
  end
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end
  return "<S-Tab>"
end, opts)

keymap.set("i", "<CR>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#confirm"]()
  end
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
    return "<C-y>"
  end
  return "\r"
end, opts)

if vim.g.neovide then
  keymap.set({ "n", "v" }, "<D-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end, { desc = "Increase Neovide scale" })
  keymap.set({ "n", "v" }, "<D-->", function()
    vim.g.neovide_scale_factor = math.max(0.5, vim.g.neovide_scale_factor - 0.1)
  end, { desc = "Decrease Neovide scale" })
  keymap.set({ "n", "v" }, "<D-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Reset Neovide scale" })
end
