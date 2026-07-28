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
local theme_ready = false

local function apply_bg(bg)
  local changed = bg ~= current_bg
  if changed then
    current_bg = bg
    vim.opt.background = bg
  end

  if theme_ready and (changed or vim.g.colors_name ~= "lanciabones") then
    vim.cmd.colorscheme("lanciabones")
  end
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

-- Set the background immediately, then load the full colorscheme only after a
-- UI attaches. Headless sessions never pay for the Lush/Zenbones stack.
apply_bg(override_bg() or "dark")

vim.api.nvim_create_autocmd("UIEnter", {
  group = user_augroup,
  once = true,
  callback = function()
    theme_ready = true
    apply_bg(current_bg)
    refresh_background_async()
  end,
})

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

vim.api.nvim_create_autocmd("FileType", {
  group = user_augroup,
  pattern = "markdown",
  callback = function()
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
