local fn = require "fn"
local cmd, map = fn.cmd_fn, fn.map_fn

local saga_status, saga = pcall(require, "lspsaga")
if saga_status then
  saga.init_lsp_saga {
    border_style = "double",
    max_preview_lines = 25,
    symbol_in_winbar = {
      enable = true,
      in_custom = false,
      click_support = false,
      show_file = true,
      file_formatter = "%:.", -- relative filename
      separator = "  ",
    },
    finder_action_keys = {
      open = { "o", "<CR>" },
      quit = { "q", "<Esc>" },
      vsplit = "v",
      split = "s",
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
    show_outline = { auto_enter = false, jump_key = "<CR>" },
    finder_request_timeout = 5000,
    finder_icons = { def = " ", imp = " ", ref = " " },
    rename_action_quit = "<Esc>",
    definition_action_keys = { quit = "q" },
    code_action_lightbulb = { enable = false },
  }

  map("n", "gf", cmd("Lspsaga", { "lsp_finder" }), { desc = "Lsp Finder" })
  map("n", "gp", cmd("Lspsaga", { "peek_definition" }), { desc = "Lsp Peek Definition" })
end

local hint_status, hint = pcall(require, "lsp-inlayhints")
if hint_status then
  hint.setup {
    inlay_hints = {
      type_hints = { prefix = " " },
      parameter_hints = { prefix = " " },
    },
  }
end

local tokens_status, tokens = pcall(require, "nvim-semantic-tokens")
if tokens_status then
  tokens.setup {
    preset = "default",
    highlighters = { require "nvim-semantic-tokens.table-highlighter" },
  }
end

local document_color_status, document_color = pcall(require, "document-color")
if document_color_status then document_color.setup { mode = "background" } end

local glance_status, glance = pcall(require, "glance")
if glance_status then
  glance.setup {
    border = { enable = true, top_char = "─", bottom_char = "─" },
    folds = { folded = true, fold_open = "▾", fold_closed = "▸" },
    list = { position = "right", width = 0.3 },
    theme = { enable = true, mode = "auto" },
  }
  local set = vim.keymap.set
  set("n", "<C-g>d", [[<CMD>Glance definitions<CR>]], { desc = "Peek Definition" })
  set("n", "<C-g>r", [[<CMD>Glance references<CR>]], { desc = "Peek References" })
  set("n", "<C-g>t", [[<CMD>Glance type_definitions<CR>]], { desc = "Peek TypeDefinitions" })
  set("n", "<C-g>i", [[<CMD>Glance implementations<CR>]], { desc = "Peek Implementations" })
end
