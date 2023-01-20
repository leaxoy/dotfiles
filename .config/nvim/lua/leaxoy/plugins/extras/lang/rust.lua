return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    ---@type LazyLspConfig
    opts = {
      setups = {
        rust_analyzer = function(opts)
          require("rust-tools").setup {
            tools = { inlay_hints = { auto = false } },
            server = opts or {},
            dap = {
              adapter = { type = "executable", command = "codelldb", name = "codelldb" },
            },
          }
        end,
      },
    },
  },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
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

      vim.api.nvim_create_autocmd("BufRead", {
        pattern = { "Cargo.toml" },
        callback = function()
          local cmd = vim.api.nvim_create_user_command
          cmd("CargoReload", crates.reload, { desc = "Reload Cargo Workspace" })
          cmd("CargoUpdate", crates.update_crate, { desc = "Update Cargo Dependencies" })
          cmd(
            "CargoUpdateAll",
            crates.update_all_crates,
            { desc = "Update All Cargo Dependencies" }
          )
          require("cmp").setup.buffer { sources = { { name = "crates" } } }
        end,
        desc = "Cargo Setup",
      })
    end,
  },
}
