return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "rcarriga/nvim-notify",
    config = function() require("notify").setup { background_colour = "#000000" } end,
  },
  "mfussenegger/nvim-jdtls",
  {
    "windwp/nvim-autopairs",
    event = "BufReadPost",
    config = function() require("nvim-autopairs").setup {} end,
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function() require("Comment").setup { mappings = { extra = false } } end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("todo-comments").setup {
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info", alt = { "todo" } },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      }
    end,
  },

  {
    "p00f/godbolt.nvim",
    config = function() require("godbolt").setup {} end,
  },

  { "ThePrimeagen/refactoring.nvim" },

  {
    "folke/neoconf.nvim",
    keys = {
      { "<leader>w,", [[<CMD>Neoconf global<CR>]], desc = "Global Settings" },
      { "<leader>w.", [[<CMD>Neoconf local<CR>]], desc = "Local Settings" },
    },
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
        yadm = { enable = true },
      }
    end,
  },
}
