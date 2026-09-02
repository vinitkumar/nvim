-- GUI-only settings, loaded from init.lua when running under Neovide.
-- https://neovide.dev/configuration.html

-- Option must act as Meta, otherwise macOS inserts accented characters
-- instead of sending <M-...> to Neovim.
vim.g.neovide_input_macos_option_key_is_meta = "only_left"

-- Window
vim.g.neovide_opacity = 0.95 -- < 1 is required for the blur below
vim.g.neovide_normal_opacity = 1 -- keep text background fully opaque
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_corner_radius = 0.7
vim.g.neovide_macos_simple_fullscreen = true
vim.g.neovide_proxy_icon = true -- native titlebar icon for the current file
vim.g.neovide_hide_mouse_when_typing = true

-- Animation: none while scrolling, short on the cursor.
vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.15
vim.g.neovide_cursor_short_animation_length = 0.05 -- typing
vim.g.neovide_cursor_trail_size = 0.9

-- Particle trails. Continuous GPU work, so off by default on a laptop.
-- vim.g.neovide_cursor_vfx_mode = { "railgun", "pixiedust" }
-- vim.g.neovide_cursor_vfx_particle_lifetime = 0.7

local SCALE_STEP = 0.05
local SCALE_MIN = 0.5
local SCALE_MAX = 3.0

local function scale_by(delta)
  local scale = (vim.g.neovide_scale_factor or 1) + delta
  vim.g.neovide_scale_factor = math.min(math.max(scale, SCALE_MIN), SCALE_MAX)
end

local map = vim.keymap.set

map("n", "<C-ScrollWheelUp>", function()
  scale_by(SCALE_STEP)
end, { desc = "Zoom in" })

map("n", "<C-ScrollWheelDown>", function()
  scale_by(-SCALE_STEP)
end, { desc = "Zoom out" })

map({ "n", "v" }, "<D-=>", function()
  scale_by(SCALE_STEP)
end, { desc = "Zoom in" })

map({ "n", "v" }, "<D-->", function()
  scale_by(-SCALE_STEP)
end, { desc = "Zoom out" })

map({ "n", "v" }, "<D-0>", function()
  vim.g.neovide_scale_factor = 1
end, { desc = "Reset zoom" })

-- Cmd bindings for macOS muscle memory. Normal mode already reaches the
-- system clipboard via 'clipboard', so these cover the modes that don't.
local function paste()
  vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end

map({ "i", "c", "t", "v" }, "<D-v>", paste, { silent = true, desc = "Paste" })
map("v", "<D-c>", '"+y', { desc = "Copy" })
map({ "n", "v", "i" }, "<D-s>", "<Cmd>write<CR>", { desc = "Save" })
