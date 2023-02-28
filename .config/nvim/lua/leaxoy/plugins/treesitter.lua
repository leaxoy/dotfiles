return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup {
        auto_install = true,
        highlight = { enable = true },
        incremental_selection = { enable = false },
        indent = { enable = true },

        ensure_installed = {
          "bash",
          "lua",
          "markdown",
          "markdown_inline",
          "regex",
          "vim",
        },

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
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@type LazyKeys[]
    keys = {
      { "S", "<CMD>TSJSplit<CR>", desc = "Split code block" },
      { "J", "<CMD>TSJJoin<CR>", desc = "Join code block" },
    },
    config = function() require("treesj").setup { use_default_keymaps = false } end,
  },
}
