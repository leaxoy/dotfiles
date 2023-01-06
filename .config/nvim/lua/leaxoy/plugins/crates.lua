return {
  "saecki/crates.nvim",
  event = "BufEnter Cargo.toml",
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

    vim.api.nvim_create_autocmd("BufRead", {
      pattern = { "Cargo.toml" },
      callback = function()
        cmd("CargoReload", crates.reload, { desc = "Reload Cargo Workspace" })
        cmd("CargoUpdate", crates.update_crate, { desc = "Update Cargo Dependencies" })
        cmd("CargoUpdateAll", crates.update_all_crates, { desc = "Update All Cargo Dependencies" })
      end,
      desc = "Cargo commands",
    })
  end,
}
