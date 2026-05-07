-- =============================================================================
-- autocmds.lua
-- =============================================================================
local user_augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- ---------------------------------------------------------------------------
-- Background / colorscheme
-- ---------------------------------------------------------------------------
local current_bg

local function apply_bg(bg)
  if bg == current_bg then
    return
  end
  current_bg = bg
  vim.opt.background = bg
  pcall(vim.cmd.colorscheme, "lanciabones")
end

local function override_bg()
  local override = vim.env.NVIM_BACKGROUND
  if override == "dark" or override == "light" then
    return override
  end
  return nil
end

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

-- Defer the initial colorscheme application to UIEnter, off the startup
-- critical path. Lanciabones plugin still loads eagerly (priority=1000),
-- so the only thing moved here is the actual `:colorscheme` invocation.
vim.api.nvim_create_autocmd("UIEnter", {
  group = user_augroup,
  once = true,
  callback = function()
    -- Set a default immediately so there is no flash of default colours.
    apply_bg(override_bg() or "dark")
    -- Then refine with the real macOS appearance asynchronously.
    refresh_background_async()
  end,
})

-- Re-check on focus; cheap because vim.system is async.
vim.api.nvim_create_autocmd("FocusGained", {
  group = user_augroup,
  callback = refresh_background_async,
})

-- ---------------------------------------------------------------------------
-- Strip trailing whitespace on save
-- ---------------------------------------------------------------------------
local function strip_trailing_whitespace()
  if vim.bo.binary or vim.bo.filetype == "diff" then
    return
  end
  local cursor = vim.api.nvim_win_get_cursor(0)
  local pattern = vim.bo.filetype == "mail" and [[\(^--\)\@<!\s\+$]] or [[\s\+$]]
  vim.cmd([[keeppatterns %s/]] .. pattern .. [[//e]])
  pcall(vim.api.nvim_win_set_cursor, 0, cursor)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = user_augroup,
  callback = strip_trailing_whitespace,
})

-- ---------------------------------------------------------------------------
-- Vimwiki diary template
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufNewFile", {
  group = user_augroup,
  pattern = vim.fn.expand("~") .. "/vimwiki/diary/*.wiki",
  callback = function()
    vim.cmd([[silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%']])
  end,
})

-- ---------------------------------------------------------------------------
-- Filetype-specific tweaks
-- Note: yaml and markdown filetype detection is built-in, so we don't need
-- BufNewFile/BufRead handlers just to set vim.bo.filetype.
-- ---------------------------------------------------------------------------

-- Force *.tsx into typescript.tsx (deliberately overrides the default
-- typescriptreact - keeps existing behaviour)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = user_augroup,
  pattern = "*.tsx",
  callback = function()
    vim.bo.filetype = "typescript.tsx"
  end,
})

-- Markdown indent (filetype is auto-detected from extension)
vim.api.nvim_create_autocmd("FileType", {
  group = user_augroup,
  pattern = "markdown",
  callback = function()
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
})

-- Prose / commit messages: wrap + spell
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

-- 2-space families (yaml folded in - was previously a separate autocmd)
vim.api.nvim_create_autocmd("FileType", {
  group = user_augroup,
  pattern = { "javascript", "typescript", "typescript.tsx", "json", "c", "html", "htmldjango", "yaml" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})
