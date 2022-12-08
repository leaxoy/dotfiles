require("nvim-treesitter.configs").setup {
  ensure_installed = vim.g.ts_syntaxes,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}

vim.keymap.set(
  "n",
  "<leader>si",
  vim.treesitter.show_tree,
  { desc = "Toggle TreeSitter Playground" }
)
