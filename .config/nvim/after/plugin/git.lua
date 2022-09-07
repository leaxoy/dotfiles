require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = {
      hl = "GitSignsDelete",
      text = "‾",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "~",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "double",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = { enable = false },
})

require("git").setup({
  keymaps = {
    -- Open blame window
    blame = "<Leader>vb",
    -- Close blame window
    quit_blame = "q",
    -- Open blame commit
    blame_commit = "<CR>",
    -- Open file/folder in git repository
    browse = "<Leader>vo",
    -- Open pull request of the current branch
    open_pull_request = "<Leader>vm",
    -- Create a pull request with the target branch is set in the `target_branch` option
    create_pull_request = "<Leader>vn",
    -- Opens a new diff that compares against the current index
    diff = "<Leader>vd",
    -- Close git diff
    diff_close = "q",
    -- Revert to the specific commit
    revert = "<Leader>vr",
    -- Revert the current file to the specific commit
    revert_file = "<Leader>vR",
  },
  default_branch = "master",
})

require("git-conflict").setup { default_mappings = false }
