return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
      end,
    },
  },
  opts = {
    basics = {
      options = {
        basic = true,
      },
      mappings = {
        basic = true,
        windows = true,
      },
      autocommands = {},
    },
    bracketed = {
      buffer = { suffix = "b", options = {} },
      comment = { suffix = "", options = {} },
      conflict = { suffix = "", options = {} },
      diagnostic = { suffix = "x", options = {} },
      file = { suffix = "", options = {} },
      indent = { suffix = "i", options = {} },
      jump = { suffix = "j", options = {} },
      location = { suffix = "l", options = {} },
      oldfile = { suffix = "o", options = {} },
      quickfix = { suffix = "q", options = {} },
      treesitter = { suffix = "", options = {} },
      undo = { suffix = "u", options = {} },
      window = { suffix = "w", options = {} },
      yank = { suffix = "y", options = {} },
    },
    indentscope = { symbol = "│" },
    move = {
      mappings = {
        left = "<M-Left>",
        right = "<M-Right>",
        down = "<M-Down>",
        up = "<M-Up>",
        line_left = "<M-Left>",
        line_right = "<M-Right>",
        line_down = "<M-Down>",
        line_up = "<M-Up>",
      },
    },
    statusline = { set_vim_settings = false },
    tabline = { set_vim_settings = false },
  },
  init = function()
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = { "dashboard", "lspsaga*", "sagacodeaction", "noice" },
      callback = function()
        vim.b.miniindentscope_disable = true
        vim.b.ministatusline_disable = true
        vim.b.minitabline_disable = true
      end,
    })
  end,
  ---comment
  ---@param _ LazyPlugin
  ---@param opts table<string, table>
  config = function(_, opts)
    local ai = require "mini.ai"
    ai.setup {
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = ai.gen_spec.treesitter({
          a = { "@call.outer", "@function.outer" },
          i = { "@call.inner", "@function.inner" },
        }, {}),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
      },
    }
    require("mini.basics").setup(opts.basics)
    require("mini.bracketed").setup(opts.bracketed)
    require("mini.comment").setup(opts.comment)
    require("mini.indentscope").setup(opts.indentscope)
    require("mini.move").setup(opts.move)
    require("mini.pairs").setup(opts.pairs)
    require("mini.sessions").setup(opts.sessions)
    require("mini.statusline").setup(opts.statusline)
    require("mini.surround").setup(opts.surround)
    require("mini.tabline").setup(opts.tabline)
  end,
}
