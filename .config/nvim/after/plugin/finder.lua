local status, telescope = pcall(require, "telescope")
if not status then return end

telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")
telescope.load_extension("dap")
telescope.load_extension("goimpl")
telescope.load_extension("packer")
telescope.load_extension("todo-comments")
telescope.load_extension("notify")

telescope.setup({
  defaults = {
    -- winblend = 15,
    prompt_prefix = "🔍 ",
    -- layout_strategy = "horizontal",
    layout_strategy = "bottom_pane",
    layout_config = {
      horizontal = { width = 0.7, height = 0.8, prompt_position = "bottom", preview_cutoff = 120 },
      vertical = { width = 0.8, height = 0.9, prompt_position = "bottom", preview_cutoff = 40 },
      center = { width = 0.7, height = 0.3, preview_cutoff = 10, prompt_position = "top" },
      cursor = { width = 0.8, height = 0.9, preview_cutoff = 40, },
      bottom_pane = { height = 25, prompt_position = "top", preview_cutoff = 120 },
    }
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    }
  },
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
    }
  }
})
