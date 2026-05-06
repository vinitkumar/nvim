local colors_name = "lancia"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
  palette = util.palette_extend({
    bg = hsluv "#ffffff",
    bg_muted = hsluv "#eeeeee",
    fg = hsluv "#000000",
    fg_muted = hsluv "#444444",
    fg_muted_extra = hsluv "#999999",
    constant = hsluv "#000000",
    hint = hsluv "#222222",
    warning = hsluv "#d9961a",
    error = hsluv "#ec3305",
  }, bg)
else
  palette = util.palette_extend({
    bg = hsluv "#000000",
    bg_muted = hsluv "#222222",
    fg = hsluv "#eeeeee",
    fg_muted = hsluv "#aaaaaa",
    fg_muted_extra = hsluv "#777777",
    constant = hsluv "#b36957",
    hint = hsluv "#bd9d86",
    warning = hsluv "#b18532",
    error = hsluv "#ec3305",
  }, bg)
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
  return {
    Comment { fg = palette.fg_muted },
    LineNr { fg = palette.fg_muted_extra },
    Statement { base_specs.Statement, fg = palette.fg },
    Special { fg = palette.hint },
    Type { fg = palette.fg, gui = "italic" },
    String { fg = palette.constant },
    Delimiter { fg = palette.fg_muted },
    Error { fg = palette.error },
    DiagnosticInfo { fg = palette.fg },
    DiagnosticUnderlineError { sp = palette.error, gui = "undercurl", term = "undercurl" },
    DiagnosticUnderlineWarn { sp = palette.warning, gui = "undercurl", term = "undercurl" },
    DiagnosticUnderlineHint { sp = palette.hint, gui = "undercurl", term = "undercurl", fg = palette.fg },
    DiagnosticUnderlineInfo { sp = palette.hint, gui = "undercurl", term = "undercurl" },
    NormalFloat { bg = palette.bg_muted },
    Pmenu { bg = palette.bg },
    PmenuSel { bg = palette.bg_muted },
  }
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
