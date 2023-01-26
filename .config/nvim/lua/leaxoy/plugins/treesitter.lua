return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  event = "BufReadPost",
  config = function()
    require "nvim-treesitter.configs".setup {
      auto_install = true,
      highlight = { enable = true },
      incremental_selection = { enable = false },
      indent = { enable = true },

      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "Next function start" },
          },
          goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "Next function end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "Previous function start" },
          },
          goto_previous_end = {
            ["[M"] = { query = "@function.outer", desc = "Previous function end" },
          },
          goto_next = {},
          goto_previous = {},
        },
      },
    }
  end,
}
