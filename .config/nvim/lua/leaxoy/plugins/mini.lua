return {
  "echasnovski/mini.nvim",
  event = "BufReadPost",
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
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        i = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }, {}),
      },
    }
    require("mini.comment").setup {}
    require("mini.indentscope").setup { symbol = "│" }
    require("mini.map").setup {}
    require("mini.move").setup {
      mappings = { line_left = "", line_right = "", line_down = "", line_up = "" },
    }
    require("mini.pairs").setup {}
    require("mini.sessions").setup {}
    require("mini.surround").setup {}
  end,
}
