return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  keys = {
    { "gf", [[<CMD>Lspsaga lsp_finder<CR>]], desc = "[LSP] Finder" },
    { "gp", [[<CMD>Lspsaga peek_definition<CR>]], desc = "[LSP] Peek Definition" },
  },
  cmd = "Lspsaga",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    require("lspsaga").setup {
      ui = {
        theme = "round",
        border = "rounded",
        preview = " ",
        expand = "▸",
        collapse = "▾",
        code_action = " ",
        diagnostic = " ",
        incoming = " ",
        outgoing = " ",
        colors = {
          normal_bg = "NONE",
        },
      },
      diagnostic = {},
      symbol_in_winbar = {
        enable = true,
        in_custom = false,
        show_file = true,
        separator = "  ",
        respect_root = true,
      },
      code_action = {
        num_shortcut = true,
        keys = { quit = "q", exec = "<CR>" },
      },
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        cache_code_action = true,
        sign = false,
        sign_priority = 40,
        virtual_text = true,
        update_time = 100,
      },
      preview = { lines_above = 0, lines_below = 10 },
      scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
      outline = { auto_enter = false, keys = { jump = "<CR>" } },
      callhierarchy = { show_detail = true, keys = { jump = "<CR>" } },
      request_timeout = 5000,
      finder = {
        open = { "o", "<CR>" },
        quit = { "q", "<Esc>" },
        vsplit = "v",
        split = "s",
      },
      definition = { quit = "q" },
      rename = { quit = "<Esc>" },
    }

    map { "[x", "<CMD>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" }
    map { "]x", "<CMD>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" }
    map { "<leader>xc", "<CMD>Lspsaga show_cursor_diagnostics<CR>", desc = "Cursor Diagnostic" }
    map { "<leader>xx", "<CMD>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics" }
    map { "<leader>xb", "<CMD>Lspsaga show_buf_diagnostics<CR>", desc = "Buffer Diagnostics" }
  end,
}
