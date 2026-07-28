local keymap = vim.keymap

keymap.set("n", "<C-c>", ":NvimTreeToggle<CR>")
keymap.set("n", "<C-t>", ":tabNext<CR>")
keymap.set("n", "<C-e>", function() vim.diagnostic.setloclist({ open = true }) end, { desc = "Buffer diagnostics" })
keymap.set("n", "<C-g>", ":LazyGit<CR>")
keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
keymap.set("n", "<leader>gy", function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, { desc = "Go to references" })
keymap.set("n", "<leader>gi", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
keymap.set("n", "<leader>h", ":<C-u>split<CR>")
keymap.set("n", "<leader>v", ":<C-u>vsplit<CR>")
keymap.set("n", "<leader>t", ":<C-u>tabnew<CR>")
keymap.set("n", "<leader>dt", 'i<C-r>=strftime("%c")<CR>', { noremap = true, silent = true })
keymap.set("n", "<leader>lw", function() vim.diagnostic.setqflist() end, { desc = "Workspace diagnostics" })
keymap.set("n", "<leader>lr", function() vim.cmd("LspRestart") end, { desc = "Restart LSP" })
keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })
keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action" })

keymap.set("n", "<CR>", "G")
keymap.set("n", "<BS>", "gg")
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

local expr_opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  return "<Tab>"
end, expr_opts)

keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end
  return "<S-Tab>"
end, expr_opts)

keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
    return "<C-y>"
  end
  return "\r"
end, expr_opts)
