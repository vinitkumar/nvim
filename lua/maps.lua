vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':Telescope git_files<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<C-l>', ':Telescope git_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>t', ':<C-u>tabnew<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>h', ':<C-u>split<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>v', ':<C-u>vsplit<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<C-b>', ':Telescope buffers<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<C-c>', ':Telescope git_commits<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope diagnostics bufnr=0<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabNext<CR>', {noremap = true, silent=true})


vim.api.nvim_set_keymap('n', '<Leader>z', ':ZenMode<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>r', ':NvimTreeRefresh<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeFindFile<CR>', {noremap = true, silent = true})


vim.api.nvim_set_keymap('n', '<C-c>', ':Telescope git_commits<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>t', ':<C-u>tabnew<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>h', ':<C-u>split<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>v', ':<C-u>vsplit<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabNext<CR>', {noremap = true, silent=true})

-- Up and Down mapping
vim.api.nvim_set_keymap('n', '<CR>', 'G', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<BS>', 'gg', {noremap = true, silent=true})

-- insert time
vim.api.nvim_set_keymap('n', '<Leader>dt', '"=strftime("%c")<CR>P', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>dt', '<C-R>=strftime("%c")<CR>', {noremap = true, silent=true})
