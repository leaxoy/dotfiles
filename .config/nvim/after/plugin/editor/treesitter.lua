local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.org = {
  install_info = {
    url = "https://github.com/milisims/tree-sitter-org",
    revision = "main",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  filetype = "org",
}

require("nvim-treesitter.configs").setup {
  ensure_installed = vim.g.ts_syntaxes,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "org" },
  },
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
  markid = { enable = true },
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
