return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  ---@type LazyKeys[]
  keys = {
    { "fw", "<CMD>FzfLua<CR>", desc = "Fzf" },
    { "ff", "<CMD>FzfLua files<CR>", desc = "Files" },
    { "fg", "<CMD>FzfLua live_grep_native<CR>", desc = "Grep" },
    { "fc", "<CMD>FzfLua grep_cword<CR>", desc = "Grep Cursor" },
    { "fr", "<CMD>FzfLua oldfiles<CR>", desc = "Recent Files" },
    { "fh", "<CMD>FzfLua help_tags<CR>", desc = "Neovim Help" },
    {
      "ft",
      "<CMD>lua require'fzf-lua'.live_grep_native({ cmd = 'git grep --line-number --column --color=always' })<CR>",
      desc = "Recent Files",
    },
  },
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.ui.select(...)
      require("fzf-lua").register_ui_select(function(_, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.50, row = 0.50, col = 0.5 } }
      end)
      vim.ui.select(...)
    end
  end,
  config = function()
    require("fzf-lua").setup {
      "fzf-tmux",
      fzf_tmux_opts = { ["-d"] = "50%" },
      files = { cwd_prompt = false, prompt = "Files❯ " },
    }
  end,
}
