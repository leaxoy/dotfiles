require("nvim-tree").setup({
  diagnostics = {
    enable = false,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  disable_netrw = true,
  hijack_cursor = true,
  -- open_on_setup = true,
  create_in_closed_folder = false,
  respect_buf_cwd = false,
  filters = {
    custom = {
      ".DS_Store",
      ".git",
      ".idea",
      "output",
      "__pycache__",
      "*.pyc",
      ".vscode",
    },
  },
  view = {
    hide_root_folder = true,
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = "left",
    signcolumn = "no",
    -- if true the tree will resize itself after opening a file
    -- auto_resize = true,
    -- lsp_diagnostics = true,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = true,
      -- list of mappings to set on the tree manually
      list = {
        { key = "<C-v>", action = "vsplit" },
        { key = "<C-s>", action = "split" },
        { key = "<C-[>", action = "dir_up" },
        { key = "<C-]>", action = "cd" },
        { key = "<Tab>", action = "preview" },
        { key = "r", action = "rename" },
        { key = "<C-r>", action = "full_rename" },
        { key = "d", action = "remove" },
        { key = "a", action = "create" },
        { key = "R", action = "refresh" },
        { key = "F", action = "live_filter" },
        { key = "<CR>", action = "edit" },
        { key = "g?", action = "toggle_help" },
        { key = "yn", action = "copy_name" },
        { key = "yp", action = "copy_path" },
        { key = "ya", action = "copy_absolute_path" },
        { key = "x", action = "cut" },
        { key = "c", action = "copy" },
        { key = "p", action = "paste" },
        { key = "<C-k>", action = "toggle_file_info" },
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = { enable = true },
    icons = { show = { folder_arrow = false } },
  },
  git = { enable = true, timeout = 100 },
  filesystem_watchers = { enable = true, debounce_delay = 1000 },
  actions = {
    change_dir = { enable = false },
    open_file = { resize_window = true },
  }
})

vim.keymap.set("n", "<leader>uf", "<CMD>NvimTreeToggle<CR>", { desc = "File Explorer" })
