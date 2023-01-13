return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function() require("notify").setup { background_colour = "#000000" } end,
  },
  { "mfussenegger/nvim-jdtls", ft = "java" },
  {
    "windwp/nvim-autopairs",
    event = "BufReadPost",
    config = function() require("nvim-autopairs").setup {} end,
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function() require("Comment").setup { ignore = "^$", mappings = { extra = false } } end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("todo-comments").setup {
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "fixme", "bug" } },
          TODO = { icon = " ", color = "info", alt = { "todo" } },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
          TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      }
    end,
  },

  {
    "p00f/godbolt.nvim",
    cmd = { "Godbolt", "GodboltCompiler" },
    config = function() require("godbolt").setup {} end,
  },

  { "ThePrimeagen/refactoring.nvim", event = "BufReadPost" },

  {
    "folke/neoconf.nvim",
    priority = 1000,
    keys = {
      { "<leader>w,", [[<CMD>Neoconf global<CR>]], desc = "Global Settings" },
      { "<leader>w.", [[<CMD>Neoconf local<CR>]], desc = "Local Settings" },
    },
    config = function() require("neoconf").setup {} end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
        ui = {
          border = "double",
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
        current_line_blame_opts = { delay = 150 },
        yadm = { enable = true },
      }
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function() require("colorizer").setup {} end,
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "BufWinEnter",
    config = function()
      local function click_diagnostic(args)
        if args.button == "l" then
          vim.cmd [[Lspsaga show_line_diagnostics]]
        elseif args.button == "r" then
          vim.lsp.buf.code_action()
        end
      end

      local function start_run(args)
        if args.button == "l" then vim.lsp.codelens.run() end
      end

      require("statuscol").setup {
        setopt = true,
        DiagnosticSignError = click_diagnostic,
        DiagnosticSignHint = click_diagnostic,
        DiagnosticSignInfo = click_diagnostic,
        DiagnosticSignWarn = click_diagnostic,
        CodelensRun = start_run,
        CodelensDebug = start_run,
      }
    end,
  },
}
