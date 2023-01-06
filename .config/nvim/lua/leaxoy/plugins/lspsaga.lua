return {
  "glepnir/lspsaga.nvim",
  branch = "version_2.3",
  event = "LspAttach",
  config = function()
    require("lspsaga").init_lsp_saga {
      ui = {
        theme = "round",
        border = "rounded",
        preview = " ",
        code_action = "",
        incoming = " ",
        outgoing = " ",
        normal = "NONE",
      },
      symbol_in_winbar = {
        enable = true,
        in_custom = false,
        show_file = true,
        separator = "  ",
        folder_level = 5,
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
        update_time = 100,
        sign_priority = 40,
        virtual_text = true,
      },
      preview = { lines_above = 0, lines_below = 15 },
      scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
      outline = { auto_enter = false, keys = { jump = "<CR>" } },
      call_hierarchy = { show_detail = true },
      finder = {
        request_timeout = 5000,
        keys = {
          open = { "o", "<CR>" },
          quit = { "q", "<Esc>" },
          vsplit = "v",
          split = "s",
        },
      },
      definition = { keys = { quit = "q" } },
      rename = { quit = "<Esc>" },
    }
  end,
}
