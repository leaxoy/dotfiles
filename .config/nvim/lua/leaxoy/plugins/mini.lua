return {
  {
    "echasnovski/mini.move",
    event = "BufReadPost",
    opts = {
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
    config = function(_, opts) require("mini.move").setup(opts) end,
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function(_, opts) require("mini.pairs").setup(opts) end,
  },
  {
    "echasnovski/mini.surround",
    event = "BufReadPost",
    config = function(_, opts) require("mini.surround").setup(opts) end,
  },
  {
    "echasnovski/mini.sessions",
    event = "VimEnter",
    config = function(_, opts) require("mini.sessions").setup(opts) end,
  },
  {
    "echasnovski/mini.comment",
    event = "BufReadPost",
    config = function(_, opts) require("mini.comment").setup(opts) end,
  },
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPost",
    opts = { symbol = "│" },
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = { "dashboard", "lspsaga*", "sagacodeaction", "noice" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "BufRead",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
        end,
      },
    },
    config = function()
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
    end,
  },
}
