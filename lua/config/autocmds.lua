-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
function StripTrailingWhitespace()
  if not vim.bo.binary and vim.bo.filetype ~= "diff" then
    vim.cmd("normal! mz")
    vim.cmd("normal! Hmy")
    if vim.bo.filetype == "mail" then
      -- Preserve space after e-mail signature separator
      vim.cmd("%s/\\(^--\\)\\@<!\\s\\+$//e")
    else
      vim.cmd("%s/\\s\\+$//e")
    end
    vim.cmd("normal! 'yz<Enter>")
    vim.cmd("normal! `z")
  end
end

-- Define the Grep command
vim.cmd([[
  command! -complete=dir -nargs=+ Grep silent grep <args>
        \| redraw!
        \| copen
]])

vim.cmd("autocmd BufWritePre * lua StripTrailingWhitespace()")

-- function meant to switch to dark and light based on the OS setting
function switchBackgroundAndColorScheme()
  local m = vim.fn.system("defaults read -g AppleInterfaceStyle")
  m = m:gsub("%s+", "") -- trim whitespace
  if m == "Dark" then
    vim.cmd("colorscheme tokyonight-night")
    vim.o.background = "dark"
  else
    vim.cmd("colorscheme tokyonight-day")
    vim.o.background = "light"
  end
end

vim.cmd("autocmd FocusGained,BufEnter * lua switchBackgroundAndColorScheme()")
