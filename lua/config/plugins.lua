local colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  violet = "#d183e8",
  grey = "#303030",
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

local is_linux = vim.uv.os_uname().sysname == "Linux"

return {
  is_linux and {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  } or {
    "vinitkumar/fff.nvim",
    branch = "feat/implement-buffers-support",
    build = "cargo build --release",
    lazy = false,
    keys = {},
  },
  {
    "dmmulroy/tsc.nvim",
    lazy = true,
    ft = { "typescript", "typescriptreact" },
    config = function()
      require("tsc").setup({
        bin_name = "tsgo",
        auto_open_qflist = true,
        pretty_errors = false,
        flags = "--noEmit --pretty false",
      })
    end,
  },
  { "neoclide/coc.nvim", branch = "master", build = "npm ci", event = "BufReadPre" },
  { "tpope/vim-commentary", keys = { { "gc", mode = { "n", "v" } } } },
  "duane9/nvim-rg",
  "vinitkumar/oscura-vim",
  "vinitkumar/monokai-pro-vim",
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  "sainnhe/gruvbox-material",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = bubbles_theme,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "filename", "branch" },
          lualine_c = { "%=" },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
  "sainnhe/everforest",
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {},
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  { "kdheepak/lazygit.nvim", cmd = "LazyGit" },
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = { auto_start = true, log_level = "info" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.treesitter.language.register("markdown", "markdown_inline")

      local group = vim.api.nvim_create_augroup("user_treesitter", { clear = true })
      local function enable_treesitter(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "" then
          return
        end

        pcall(vim.treesitter.start, bufnr)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          enable_treesitter(args.buf)
        end,
      })

      enable_treesitter(vim.api.nvim_get_current_buf())
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
      render = "background",
      enable_hex = true,
      enable_short_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_hsl_without_function = true,
      enable_ansi = true,
      enable_var_usage = true,
      enable_tailwind = true,
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    keys = {
      { "<leader>S", function() require("spectre").toggle() end, desc = "Toggle Spectre" },
      { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search word" },
      { "<leader>sw", function() require("spectre").open_visual() end, mode = "v", desc = "Search selection" },
    },
    opts = {},
  },
  { "vimwiki/vimwiki" },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward" },
      { "S", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward" },
      { "gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from window" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rockyzhang24/arctic.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    name = "arctic",
    branch = "main",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme arctic")
    end
  }
}
