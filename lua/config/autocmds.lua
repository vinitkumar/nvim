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

local function apply_bg(bg)
  if bg == current_bg then
    return
  end
  current_bg = bg
  vim.opt.background = bg
  vim.cmd.colorscheme("lanciabones")
end

local function override_bg()
  local override = vim.env.NVIM_BACKGROUND
  if override == "dark" or override == "light" then
    return override
  end
  return nil
end

-- Resolve the macOS appearance asynchronously so we never block startup on
-- `defaults read`. We apply a sensible default immediately, then refine when
-- the subprocess returns.
local function refresh_background_async()
  local override = override_bg()
  if override then
    apply_bg(override)
    return
  end

  if vim.fn.has("mac") ~= 1 then
    apply_bg("dark")
    return
  end

  vim.system(
    { "defaults", "read", "-g", "AppleInterfaceStyle" },
    { text = true },
    function(obj)
      local is_dark = obj.code == 0 and (obj.stdout or ""):find("Dark") ~= nil
      vim.schedule(function()
        apply_bg(is_dark and "dark" or "light")
      end)
    end
  )
end

local user_augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Only re-check on FocusGained. BufEnter fires far too often to justify
-- shelling out to `defaults read` every time.
vim.api.nvim_create_autocmd("FocusGained", {
  group = user_augroup,
  callback = refresh_background_async,
})

-- Apply a default colorscheme synchronously so there is no flash, then refine
-- with the real macOS appearance once the async probe returns.
apply_bg(override_bg() or "dark")
vim.schedule(refresh_background_async)

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
