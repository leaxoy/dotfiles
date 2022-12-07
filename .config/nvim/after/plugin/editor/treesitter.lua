require("nvim-treesitter.configs").setup {
  ensure_installed = vim.g.ts_syntaxes,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
}

vim.keymap.set(
  "n",
  "<leader>si",
  [[<CMD>TSPlaygroundToggle<CR>]],
  { desc = "Toggle TreeSitter Playground" }
)
vim.keymap.set(
  "n",
  "<leader>sp",
  [[<CMD>TSHighlightCapturesUnderCursor<CR>]],
  { desc = "Toggle TreeSitter Property" }
)
