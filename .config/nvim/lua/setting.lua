require("neoconf").setup {
  plugins = { jsonls = { configured_servers_only = false } },
}

vim.keymap.set(
  "n",
  "<leader>,",
  [[<CMD>Neoconf global<CR>]],
  { silent = true, noremap = true, desc = "Global Settings" }
)
vim.keymap.set(
  "n",
  "<leader>;",
  [[<CMD>Neoconf local<CR>]],
  { silent = true, noremap = true, desc = "Local Settings" }
)

require "setting.mason"
require "setting.neovim"
require "setting.null_ls"
require "setting.treesitter"
