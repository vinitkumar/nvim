vim.opt.guifont = vim.env.NEOVIDE_FONT or "TX-02:h15"

if not vim.g.neovide then
  return
end

vim.g.neovide_scale_factor = 1.0
vim.g.neovide_padding_top = 10
vim.g.neovide_padding_bottom = 10
vim.g.neovide_padding_left = 10
vim.g.neovide_padding_right = 10
vim.g.neovide_refresh_rate = 120
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_confirm_quit = true
