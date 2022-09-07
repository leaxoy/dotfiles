require("lspsaga").init_lsp_saga({
  border_style = "double",
  max_preview_lines = 20,
  symbol_in_winbar = {
    enable = true,
    in_custom = false,
    click_support = false,
    show_file = true,
    separator = "  "
  },
  finder_action_keys = {
    open = { "o", "<CR>" },
    quit = { "q", "<Esc>" },
    vsplit = "v",
    split = "s",
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
  finder_request_timeout = 5000,
  finder_icons = { def = " ", imp = " ", ref = " " },
  definition_preview_icon = " ",
  definition_action_keys = { quit = "q" },
  code_action_lightbulb = { enable = false },
})

require("lsp-inlayhints").setup({
  inlay_hints = {
    type_hints = { prefix = " " },
    parameter_hints = { prefix = " " }
  }
})

require("nvim-semantic-tokens").setup({
  preset = "default",
  -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
  -- function with the signature: highlight_token(ctx, token, highlight) where
  --        ctx (as defined in :h lsp-handler)
  --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
  --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
  highlighters = { require("nvim-semantic-tokens.table-highlighter") }
})
