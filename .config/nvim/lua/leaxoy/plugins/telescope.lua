return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
  ---@type LazyKeys[]
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
  },
  -- load ui-select at startup to hook vim.ui.select
  init = function()
    local hooked = false
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.ui.select(...)
      if not hooked then
        require("telescope").load_extension "ui-select"
        hooked = true
      end
      vim.ui.select(...)
    end
  end,
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
        -- initial_mode = "normal",
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
          -- folder
          ".idea/",
          ".git/",
          "kitex_gen/",
          "node_modules/",
          "vendor/",
          "target/",
          "build/",
          "output/",
          ".gradle/",

          -- specific file
          "%.class",
          "%.jar",
          "%.so",
          "%.a",
          "%.o",
          "%.out",
        },
        -- path_display = { shorten = 1 },
        dynamic_preview_title = true,
        -- layout_strategy = "horizontal",
        layout_strategy = "bottom_pane",
        layout_config = {
          horizontal = { width = 0.8, height = 0.8 },
          vertical = { width = 0.8, height = 0.8, prompt_position = "center" },
          center = { prompt_position = "top" },
          cursor = { height = 0.9 },
          bottom_pane = { prompt_position = "top", height = 0.6 },

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
        builtin = { previewer = false },
        colorscheme = { enable_preview = true },
        find_files = { hidden = true },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          layout_config = { height = 0.6 },
          respect_gitignore = true,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
        },
        live_grep_args = { auto_quoting = true },
        notify = { initial_mode = "normal" },
        ["ui-select"] = { themes.get_dropdown {} },
      },
    }

    telescope.load_extension "fzf"
    telescope.load_extension "file_browser"
    telescope.load_extension "live_grep_args"
    pcall(telescope.load_extension, "notify")
    pcall(telescope.load_extension, "noice")
  end,
}
