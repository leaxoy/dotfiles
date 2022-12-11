local status, telescope = pcall(require, "telescope")
if not status then return end

local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local extensions = telescope.extensions
local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"

telescope.setup {
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "> ",
    multi_icon = "+",
    -- default border is ivy border config
    border = true,
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    sorting_strategy = "ascending",
    results_title = false,
    file_ignore_patterns = {
      ".git",
      "kitex_gen",
      "node_modules",
      "vendor",
      "target",
      "build",
      "output",
    },
    path_display = { shorten = 1 },
    dynamic_preview_title = true,
    -- layout_strategy = "horizontal",
    layout_strategy = "bottom_pane",
    layout_config = {
      horizontal = { width = 0.8, height = 0.8 },
      vertical = { width = 0.8, height = 0.8, prompt_position = "center" },
      center = { prompt_position = "top" },
      cursor = { height = 0.9 },
      bottom_pane = { prompt_position = "top" },

      height = 0.5,
      preview_cutoff = 80,
      width = 0.6,
      prompt_position = "bottom",
    },
    mappings = {
      n = { v = actions.file_vsplit },
      i = {
        ["<C-f>"] = false,
        ["<C-v>"] = actions.file_vsplit,
      },
    },
    color_devicons = true,
    set_env = { COLORTERM = "truecolor" },

    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    prefilter_sorter = sorters.prefilter,

    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    buffer_previewer_maker = previewers.buffer_previewer_maker,
  },
  pickers = {
    buffers = { initial_mode = "normal" },
    builtin = { previewer = false },
    colorscheme = { enable_preview = true },
    diagnostics = { initial_mode = "normal" },
    find_files = { hidden = true },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = {},
        ["n"] = {},
      },
      layout_config = { height = 0.6 },
      respect_gitignore = true,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
    },
    live_grep_args = {
      auto_quoting = true,
    },
    notify = { initial_mode = "normal" },
    ["ui-select"] = {
      themes.get_dropdown {},
    },
  },
}

pcall(telescope.load_extension, "file_browser")
pcall(telescope.load_extension, "live_grep_args")
pcall(telescope.load_extension, "dap")
pcall(telescope.load_extension, "todo-comments")
pcall(telescope.load_extension, "notify")
pcall(telescope.load_extension, "ui-select")

keymap("n", "f", partial(show_keymap, "f"), { desc = "+Finder" })
keymap("n", "fw", builtin.builtin, { desc = "Open Telescope Window" })
keymap("n", "ff", builtin.find_files, { desc = "File Finder" })
keymap("n", "fl", extensions.file_browser.file_browser, { desc = "File Browser" })
keymap("n", "fg", extensions.live_grep_args.live_grep_args, { desc = "Live Grep" })
keymap("n", "fc", builtin.grep_string, { desc = "Grep Cursor String" })
keymap("n", "fh", builtin.help_tags, { desc = "Help" })
keymap("n", "fb", builtin.buffers, { desc = "All Buffers" })
keymap("n", "fn", extensions.notify.notify, { desc = "Notifications" })
keymap("n", "fx", builtin.diagnostics, { desc = "Diagnostics" })
keymap("n", "ft", [[<CMD>TodoTelescope<CR>]], { desc = "Todo List" })
keymap("n", "fd", partial(show_keymap, "fd"), { desc = "+Dap" })
keymap("n", "fdb", extensions.dap.list_breakpoints, { desc = "Dap: List Breakpoints" })
keymap("n", "fdc", extensions.dap.configurations, { desc = "Dap: Configurations" })
keymap("n", "fdf", extensions.dap.frames, { desc = "Dap: Frames" })
keymap("n", "fdv", extensions.dap.variables, { desc = "Dap: Variables" })
