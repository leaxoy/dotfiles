local status, telescope = pcall(require, "telescope")
if not status then return end

telescope.setup {
  defaults = {
    -- winblend = 15,
    prompt_prefix = "🔍 ",
    file_ignore_patterns = { ".git", "kitex_gen", "node_modules", "vendor", "target", "build", "output" },
    path_display = { shorten = 1 },
    dynamic_preview_title = true,
    -- layout_strategy = "horizontal",
    layout_strategy = "bottom_pane",
    layout_config = {
      horizontal = { width = 0.7, height = 0.8, prompt_position = "bottom", preview_cutoff = 120 },
      vertical = { width = 0.8, height = 0.9, prompt_position = "bottom", preview_cutoff = 40 },
      center = { width = 0.7, height = 0.3, preview_cutoff = 10, prompt_position = "top" },
      cursor = { width = 0.8, height = 0.9, preview_cutoff = 40 },
      bottom_pane = { height = 25, prompt_position = "top", preview_cutoff = 100 },
    },
    mappings = {
      i = {
        ["<C-u>"] = false,
      },
    },
  },
  -- pickers = {},
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {},
        ["n"] = {},
      }
    },
    live_grep_args = {
      auto_quoting = true,
    },
    ["ui-select"] = {
      layout_strategy  = "center",
      layout_config    = { height = 12 },
      sorting_strategy = "ascending",
    },
  }
}

telescope.load_extension "file_browser"
telescope.load_extension "live_grep_args"
telescope.load_extension "dap"
telescope.load_extension "todo-comments"
telescope.load_extension "notify"
telescope.load_extension "ui-select"

local fn = require("fn")
local map, cmd, popup = fn.map_fn, fn.cmd_fn, fn.popup_fn

local builtin = require("telescope.builtin")
map("n", "f", popup "f", { desc = "+Finder" })
map("n", "fw", cmd "Telescope", { desc = "Open Telescope Window" })
map("n", "ff", function() builtin.find_files { hidden = true } end, { desc = "File Finder" })
map("n", "fl", function()
  telescope.extensions.file_browser.file_browser {
    -- path = "%:p:h",
    respect_gitignore = true,
    hidden = true,
    grouped = true,
    -- previewer = true,
    initial_mode = "normal",
  }
end, { desc = "File Browser" })
map("n", "fg", cmd("Telescope", { "live_grep_args" }), { desc = "Live Grep" })
map("n", "fc", cmd("Telescope", { "grep_string" }), { desc = "Grep Cursor String" })
map("n", "fh", cmd("Telescope", { "help_tags" }), { desc = "Help" })
map("n", "fb", cmd("Telescope", { "buffers" }), { desc = "All Buffers" })
map("n", "fn", cmd("Telescope", { "notify" }), { desc = "Notifications" })
map("n", "fd", cmd("Telescope", { "diagnostics" }), { desc = "Diagnostics" })
-- in favor of lspsaga
-- map("n", "fr", cmd("Telescope", { "lsp_references" }), { desc = "[LSP] References" })
-- map("n", "fi", cmd("Telescope", { "lsp_implementations" }), { desc = "[LSP] Implementations" })
-- map("n", "fs", cmd("Telescope", { "lsp_document_symbols" }), { desc = "[LSP] Document Symbols" })
map("n", "fo", cmd("Telescope", { "lsp_dynamic_workspace_symbols" }), { desc = "[LSP] Workspace Symbols" })
map("n", "ft", cmd "TodoTelescope", { desc = "Todo List" })
