return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  keys = {
    { "gf", [[<CMD>Lspsaga lsp_finder<CR>]], desc = "[LSP] Finder" },
  },
  config = function()
    require("lspsaga").setup {
      ui = {
        theme = "round",
        border = "rounded",
        preview = " ",
        expand = "▸",
        collaspe = "▾",
        code_action = " ",
        diagnostic = " ",
        incoming = " ",
        outgoing = " ",
        colors = {
          normal_bg = "NONE",
        },
      },
      diagnostic = {
        twice_into = true,
        keys = { exec_action = "<CR>" },
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

    vim.keymap.del("n", "[x")
    vim.keymap.del("n", "]x")
    vim.keymap.del("n", "<leader>xx")
    vim.keymap.del("n", "<leader>xb")
    local m = keymap
    m("n", "[x", [[<CMD>Lspsaga diagnostic_jump_prev<CR>]], { desc = "Prev Diagnostic" })
    m("n", "]x", [[<CMD>Lspsaga diagnostic_jump_next<CR>]], { desc = "Next Diagnostic" })
    m("n", "<leader>xx", "<CMD>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics" })
    m("n", "<leader>xb", "<CMD>Lspsaga show_buf_diagnostics<CR>", { desc = "Buffer Diagnostics" })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = vim.api.nvim_create_augroup("diagnostic", {}),
      command = "Lspsaga show_cursor_diagnostics",
      desc = "automatic open float diagnostic window",
    })
  end,
}
