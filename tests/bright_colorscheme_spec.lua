vim.opt.runtimepath:prepend(vim.fn.getcwd())
vim.cmd.colorscheme("bright")

local function color(value)
  return tonumber(value:sub(2), 16)
end

local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
assert(normal_float.fg == color("#f5f5f5"), "expected NormalFloat foreground to use Bright base06")
assert(normal_float.bg == color("#303030"), "expected NormalFloat background to use Bright base01")

local float_border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
assert(float_border.fg == color("#f5f5f5"), "expected FloatBorder foreground to use Bright base06")
assert(float_border.bg == color("#303030"), "expected FloatBorder background to use Bright base01")

local float_title = vim.api.nvim_get_hl(0, { name = "FloatTitle" })
assert(float_title.link == "Title", "expected FloatTitle to link to Title")

vim.cmd("quitall!")
