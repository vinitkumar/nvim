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

return {
  {
    'vinitkumar/fff-plus.nvim',
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    lazy = false, -- fff-plus.nvim lazy-initializes itself
    opts = {
      download = {
        github_repo = 'vinitkumar/fff-plus.nvim',
      },
    },
    keys = {
      { "<C-p>", function() require("fff").find_files() end, desc = "Find files" },
      { "<C-b>", function() require("fff").buffers() end, desc = "Find buffers" },
      { '<leader>g', function() require('fff').git_files() end, desc = 'FFF git files' },
      { '<leader>c', function() require('fff').colors() end, desc = 'FFF colors' },
      { 'fg', function() require('fff').live_grep() end, desc = 'FFF grep' },
    },
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

  { "tpope/vim-commentary", keys = { { "gc", mode = { "n", "v" } } } },
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
          lualine_x = {
            function()
              return vim.diagnostic.status()
            end,
            function()
              return vim.ui.progress_status()
            end,
          },
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
  {
    "lukas-reineke/indent-blankline.nvim",
    ft = {
      "c",
      "css",
      "go",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "lua",
      "ocaml",
      "python",
      "ruby",
      "typescript",
      "typescriptreact",
      "yaml",
    },
    main = "ibl",
    opts = {
      scope = {
        enabled = false,
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  { "kdheepak/lazygit.nvim", cmd = "LazyGit" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ft = {
      "c",
      "go",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "lua",
      "ocaml",
      "python",
      "ruby",
      "typescript",
      "typescriptreact",
      "yaml",
    },
    config = function()
      local group = vim.api.nvim_create_augroup("user_treesitter", { clear = true })
      local function enable_treesitter(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        local filetype = vim.bo[bufnr].filetype
        if vim.bo[bufnr].buftype ~= "" or filetype == "" then
          return
        end

        if vim.api.nvim_buf_line_count(bufnr) > 5000 then
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
    ft = {
      "css",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
    },
    opts = {
      render = "background",
      enable_hex = true,
      enable_short_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_hsl_without_function = false,
      enable_ansi = false,
      enable_var_usage = false,
      enable_tailwind = false,
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(_, filetype, buftype)
        if buftype ~= "" then
          return ""
        end

        if filetype == "markdown" or filetype == "text" or filetype == "gitcommit" then
          return { "indent" }
        end

        return { "treesitter", "indent" }
      end,
    },
    init = function()
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = false
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      { "<leader>S", function() require("grug-far").open() end, desc = "Search and replace" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search word" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, mode = "v", desc = "Search selection" },
    },
    opts = {},
  },
  { "vimwiki/vimwiki", ft = "vimwiki", cmd = { "VimwikiIndex", "VimwikiDiaryIndex" } },
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
    "vinitkumar/lanciabones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
      "zenbones-theme/zenbones.nvim",
    },
    lazy = false,
    priority = 1000,
  },
  {
  "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
