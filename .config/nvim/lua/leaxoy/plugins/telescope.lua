return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
  keys = {
    { "fw", [[<CMD>Telescope<CR>]], desc = "Telescope Window" },
    { "ff", [[<CMD>Telescope find_files<CR>]], desc = "File Finder" },
    { "fl", [[<CMD>Telescope file_browser<CR>]], desc = "File Browser" },
    { "fg", [[<CMD>Telescope live_grep_args<CR>]], desc = "Live Grep" },
    { "fc", [[<CMD>Telescope grep_string<CR>]], desc = "Grep Cursor String" },
    { "fh", [[<CMD>Telescope help_tags<CR>]], desc = "Help" },
    { "fb", [[<CMD>Telescope buffers<CR>]], desc = "All Buffers" },
    { "fn", [[<CMD>Telescope notify<CR>]], desc = "Notifications" },
    { "fx", [[<CMD>Telescope diagnostics<CR>]], desc = "Diagnostics" },
    { "ft", [[<CMD>TodoTelescope<CR>]], desc = "Todo List" },
    { "fdb", [[<CMD>Telescope dap list_breakpoints<CR>]], desc = "Dap: List Breakpoints" },
    { "fdc", [[<CMD>Telescope dap configurations<CR>]], desc = "Dap: Configurations" },
    { "fdf", [[<CMD>Telescope dap frames<CR>]], desc = "Dap: Frames" },
    { "fdv", [[<CMD>Telescope dap variables<CR>]], desc = "Dap: Variables" },
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local previewers = require "telescope.previewers"
    local sorters = require "telescope.sorters"
    local themes = require "telescope.themes"

    telescope.setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = "> ",
        multi_icon = "+",
        initial_mode = "normal",
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
        builtin = { previewer = false, initial_mode = "insert" },
        colorscheme = { enable_preview = true },
        find_files = { hidden = true, initial_mode = "insert" },
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
          -- initial_mode = "normal",
        },
        live_grep_args = {
          auto_quoting = true,
          initial_mode = "insert",
        },
        notify = { initial_mode = "normal" },
        ["ui-select"] = { themes.get_dropdown {} },
      },
    }

    pcall(telescope.load_extension, "file_browser")
    pcall(telescope.load_extension, "live_grep_args")
    pcall(telescope.load_extension, "dap")
    pcall(telescope.load_extension, "todo-comments")
    pcall(telescope.load_extension, "notify")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "noice")
  end,
}
