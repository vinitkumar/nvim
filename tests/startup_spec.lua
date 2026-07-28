local function assert_mapping(lhs, description)
  local mapping = vim.fn.maparg(lhs, "n", false, true)
  assert(mapping.desc == description, ("expected %s to map to %s"):format(lhs, description))
end

local function has_float_title(expected)
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    local title = vim.api.nvim_win_get_config(window).title
    if type(title) == "table" then
      local text = ""
      for _, chunk in ipairs(title) do
        text = text .. chunk[1]
      end
      if text:find(expected, 1, true) then
        return true
      end
    end
  end
  return false
end

local startup_ms = (vim.uv.hrtime() - vim.g.config_start_time_ns) / 1e6
assert(startup_ms < 50, ("expected config startup under 50 ms, got %.1f ms"):format(startup_ms))

assert(package.loaded["fff"] == nil, "expected fff to remain unloaded during startup")
assert(package.loaded["fff_plus"] == nil, "expected fff_plus to remain unloaded during startup")
assert(package.loaded["lush"] == nil, "expected the colorscheme stack to remain unloaded until UI startup")
assert(package.loaded["zenbones.util"] == nil, "expected zenbones to remain unloaded until UI startup")
assert(package.loaded["vim.lsp"] == nil, "expected LSP to remain unloaded until an LSP filetype opens")

assert_mapping("<C-p>", "Find files")
assert_mapping("<C-b>", "Find buffers")
assert_mapping("fg", "FFF grep")
assert_mapping("<leader>g", "FFF git files")
assert_mapping("<leader>c", "FFF colors")
assert_mapping("gc", "Toggle comment")
assert_mapping("grx", "vim.lsp.codelens.run()")

assert(vim.o.completeopt == "menuone,noselect,popup,fuzzy", "expected modern insert completion behavior")
assert(vim.o.wildmode == "noselect:lastused,full", "expected non-selecting command-line completion")
assert(vim.o.wildoptions == "pum,fuzzy", "expected fuzzy command-line completion")

vim.api.nvim_exec_autocmds("UIEnter", {})
assert(vim.g.colors_name == "bright", "expected the configured colorscheme after UI startup")

local ui_ready_ms = (vim.uv.hrtime() - vim.g.config_start_time_ns) / 1e6
assert(ui_ready_ms < 75, ("expected UI-ready startup under 75 ms, got %.1f ms"):format(ui_ready_ms))

local original_notify = vim.notify
vim.notify = function() end
local triggered, trigger_error = pcall(vim.api.nvim_feedkeys, vim.keycode("<leader>g"), "x", false)
vim.notify = original_notify

assert(triggered, "expected <leader>g finder mapping to run: " .. tostring(trigger_error))
assert(package.loaded["fff"] ~= nil, "expected <leader>g to lazy-load fff")
assert(package.loaded["fff_plus"] ~= nil, "expected <leader>g to lazy-load fff_plus")
assert(has_float_title("Git Files"), "expected <leader>g to open the Git file finder")
assert(vim.fn.exists(":FFFPlusBuffers") == 2, "expected fff-plus commands after lazy loading")

vim.bo.filetype = "lua"
assert(package.loaded["config.lsp"] ~= nil, "expected LSP config to load for a Lua buffer")
assert(vim.lsp.config.lua_ls ~= nil, "expected lua_ls to remain configured after lazy loading")

local diagnostic_config = vim.diagnostic.config()
assert(diagnostic_config.severity_sort, "expected diagnostics to sort by severity")
assert(
  diagnostic_config.virtual_lines and diagnostic_config.virtual_lines.current_line,
  "expected diagnostic virtual lines on the current line"
)

vim.cmd.edit("/tmp/nvim-config-startup-spec.tsx")
assert(vim.bo.filetype == "typescriptreact", "expected Neovim's native TSX filetype")

vim.cmd("quitall!")
