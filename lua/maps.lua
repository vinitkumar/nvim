vim.g.mapleader = ","
local keymap = vim.keymap

-- split settings
keymap.set('n', '<Leader>h', ':<C-u>split<CR>', {noremap = true, silent=true})
keymap.set('n', '<Leader>v', ':<C-u>vsplit<CR>', {noremap = true, silent=true})


-- tab settings
keymap.set('n', '<Leader>t', ':<C-u>tabnew<CR>', {noremap = true, silent=true})
keymap.set('n', '<C-t>', ':tabNext<CR>', {noremap = true, silent=true})


-- Up and Down Mapping
keymap.set('n', '<CR>', 'G', {noremap = true, silent=true})
keymap.set('n', '<BS>', 'gg', {noremap = true, silent=true})
