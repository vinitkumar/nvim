local function strip_trailing_whitespace()
  if vim.bo.binary or vim.bo.filetype == "diff" then
    return
  end
  local cursor = vim.api.nvim_win_get_cursor(0)
  local pattern = vim.bo.filetype == "mail" and [[\(^--\)\@<!\s\+$]] or [[\s\+$]]
  vim.cmd([[keeppatterns %s/]] .. pattern .. [[//e]])
  pcall(vim.api.nvim_win_set_cursor, 0, cursor)
end

local current_bg

local function macos_is_dark()
  -- `defaults read -g AppleInterfaceStyle` exits non-zero and prints nothing
  -- when the system is in Light mode, and prints "Dark" when in Dark mode.
  local out = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
  out = (out or ""):gsub("%s+", "")
  return out == "Dark"
end

local function desired_background()
  local override = vim.env.NVIM_BACKGROUND
  if override == "dark" or override == "light" then
    return override
  end

  -- Honour the macOS appearance. Anywhere else we have no portable way to
  -- detect it, so default to dark.
  if vim.fn.has("mac") == 1 then
    return macos_is_dark() and "dark" or "light"
  end

  return "dark"
end

local function switch_background_and_colorscheme()
  local bg = desired_background()
  if bg == current_bg then
    return
  end

  current_bg = bg
  vim.opt.background = bg
  vim.cmd.colorscheme("lanciabones")
end

local user_augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Only re-check on FocusGained. BufEnter fires far too often to justify
-- shelling out to `defaults read` every time.
vim.api.nvim_create_autocmd("FocusGained", {
  group = user_augroup,
  callback = switch_background_and_colorscheme,
})

switch_background_and_colorscheme()

vim.api.nvim_create_autocmd("BufWritePre", {
  group = user_augroup,
  callback = strip_trailing_whitespace,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  group = user_augroup,
  pattern = vim.fn.expand("~") .. "/vimwiki/diary/*.wiki",
  callback = function()
    vim.cmd([[silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%']])
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = user_augroup,
  pattern = "*.md",
  callback = function()
    vim.bo.filetype = "markdown"
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = user_augroup,
  pattern = { "*.md", "*.txt", "*.adoc", "*.html", "COMMIT_EDITMSG" },
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.list = false
    vim.wo.spell = true
    vim.bo.spelllang = "en_us"
    vim.opt_local.complete:append("kspell")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = user_augroup,
  pattern = "gitcommit",
  callback = function()
    vim.wo.spell = true
    vim.bo.textwidth = 72
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = user_augroup,
  pattern = { "javascript", "typescript", "json", "c", "html", "htmldjango" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = user_augroup,
  pattern = "*.tsx",
  callback = function()
    vim.bo.filetype = "typescript.tsx"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = user_augroup,
  pattern = { "*.yaml", "*.yml" },
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = user_augroup,
  pattern = "yaml",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})
