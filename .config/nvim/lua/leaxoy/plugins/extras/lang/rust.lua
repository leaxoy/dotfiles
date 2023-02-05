return {
  {
    "neovim/nvim-lspconfig",
    ---@type LazyLspConfig
    opts = {
      servers = {
        rust_analyzer = {},
      },
    },
  },
  {
    "saecki/crates.nvim",
    event = "BufReadPre Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
    config = function()
      local crates = require "crates"

      crates.setup {
        null_ls = { enabled = true, name = "cargo" },
        popup = {
          border = "rounded",
          show_version_date = true,
          text = { pill_left = " ", pill_right = "" },
        },
      }

      local cmd = vim.api.nvim_create_user_command
      cmd("CrateReload", function() crates.reload(0) end, { desc = "Reload Workspace" })
      cmd("CrateUpdate", crates.upgrade_crate, { desc = "Update Cargo Dependence" })
      cmd("CrateUpdateAll", crates.upgrade_all_crates, { desc = "Update All Cargo Dependencies" })
      require("cmp").setup.buffer { sources = { { name = "crates" } } }
    end,
  },
}
