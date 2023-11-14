-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

keymap.set("n", "<Leader>z", ":ZenMode<CR>", { noremap = true, silent = true })
-- split settings
keymap.set("n", "<Leader>h", ":<C-u>split<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>v", ":<C-u>vsplit<CR>", { noremap = true, silent = true })

-- tab settings
keymap.set("n", "<Leader>t", ":<C-u>tabnew<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-t>", ":tabNext<CR>", { noremap = true, silent = true })

-- Up and Down Mapping
keymap.set("n", "<CR>", "G", { noremap = true, silent = true })
keymap.set("n", "<BS>", "gg", { noremap = true, silent = true })

keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-b>", ":Telescope buffers<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-c>", ":Telescope git_commits<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-e>", ":Telescope diagnostics bufnr=0<CR>", { noremap = true, silent = true })
