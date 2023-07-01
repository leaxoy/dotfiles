return {
  {
    "folke/lazy.nvim",
    init = function()
      map { "<leader>lp", "<CMD>Lazy<CR>", desc = "Manage Plugins" }
      map { "<leader>wu", "<CMD>Lazy sync<CR>", desc = "Update Plugins" }
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function() require("notify").setup { background_colour = "#000000" } end,
  },
  { "mfussenegger/nvim-jdtls", lazy = true },

  {
    "folke/neoconf.nvim",
    priority = 1000,
    cmd = "Neoconf",
    keys = {
      { "<leader>w,", [[<CMD>Neoconf global<CR>]], desc = "Global Settings" },
      { "<leader>w.", [[<CMD>Neoconf local<CR>]], desc = "Local Settings" },
    },
    config = true,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    ---@type LazyKeys[]
    keys = {
      { "<leader>lm", "<CMD>Mason<CR>", desc = "Manage Mason" },
    },
    opts = {
      ---@type table<string, string|string[]>
      dependencies = {},
    },
    config = function(_, opts)
      require("mason").setup {
        ui = {
          height = 0.8,
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      }

      local registry = require "mason-registry"
      for _, dependence in pairs(opts.dependencies) do
        local pkg = registry.get_package(dependence)
        if not pkg:is_installed() then pkg:install {} end
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    cmd = "Gitsigns",
    ---@type LazyKeys[]
    keys = {
      { "<leader>vd", "<CMD>Gitsigns diffthis<CR>", desc = "Diff This Hunk" },
      { "<leader>vp", "<CMD>Gitsigns preview_hunk_inline<CR>", desc = "Preview Diff" },
      { "[h", "<CMD>Gitsigns prev_hunk<CR>", desc = "Previous hunk" },
      { "]h", "<CMD>Gitsigns next_hunk<CR>", desc = "Next hunk" },
    },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 150 },
      yadm = { enable = true },
    },
  },
  { "tpope/vim-fugitive" },

  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

  { "zaldih/themery.nvim", config = function() require("themery").setup {} end },
}
