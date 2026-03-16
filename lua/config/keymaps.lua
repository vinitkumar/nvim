local keymap = vim.keymap

keymap.set("n", "<C-p>", function() require("fff").find_files() end, { desc = "Find files" })
keymap.set("n", "<C-b>", function() require("fff").buffers() end, { desc = "Find files" })
keymap.set("n", "<C-h>", function() require("fff").git_files() end, { desc = "Find Git files for Commit" })
keymap.set("n", "<C-c>", ":NvimTreeToggle<CR>")
keymap.set("n", "<C-t>", ":tabNext<CR>")
keymap.set("n", "<C-e>", ":CocDiagnostics<CR>")
keymap.set("n", "<C-s>", ":GFiles<CR>")
keymap.set("n", "<C-g>", ":LazyGit<CR>")
keymap.set("n", "<leader>gd", "<Plug>(coc-definition)")
keymap.set("n", "<leader>gy", "<Plug>(coc-type-definition)")
keymap.set("n", "<leader>gr", "<Plug>(coc-references)")
keymap.set("n", "<leader>gi", "<Plug>(coc-implementation)")
keymap.set("n", "<leader>h", ":<C-u>split<CR>")
keymap.set("n", "<leader>z", ":<C-u>Goyo<CR>")
keymap.set("n", "<leader>v", ":<C-u>vsplit<CR>")
keymap.set("n", "<leader>t", ":<C-u>tabnew<CR>")
keymap.set("n", "<leader>dt", 'i<C-r>=strftime("%c")<CR>', { noremap = true, silent = true })

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
  if check_back_space() then
    return vim.fn["coc#refresh"]()
  end
  return "<Tab>"
end, opts)

keymap.set("i", "<S-Tab>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#prev"](1)
  end
  return "<S-Tab>"
end, opts)

keymap.set("i", "<CR>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#confirm"]()
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
