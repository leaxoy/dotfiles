require("nvim-treesitter.configs").setup {
  ensure_installed = vim.g.ts_syntaxes,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}

vim.keymap.set(
  "n",
  "<leader>si",
  function() vim.treesitter.show_tree { command = "topleft 50vnew" } end,
  { desc = "Toggle TreeSitter Playground" }
)
