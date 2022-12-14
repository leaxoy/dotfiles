return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require "which-key"
    wk.setup {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = { enabled = true, suggestions = 20 },
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      operators = { gc = "Comments" },
      key_labels = { ["<space>"] = "SPC", ["<cr>"] = "RET", ["<tab>"] = "TAB" },
      -- icons = { breadcrumb = "", separator = "", group = " " },
      popup_mappings = { scroll_down = "<c-d>", scroll_up = "<c-u>" },
      window = {
        border = "rounded", -- none, single, double, shadow
        --   position = "bottom", -- bottom, top
        --   margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        --   padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        --   winblend = 0,
      },
      layout = {
        --   height = { min = 4, max = 25 }, -- min and max height of the columns
        --   width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = false, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      show_keys = true,
    }
    wk.register {
      mode = { "n", "v" },
      f = { name = "+Finder" },
      fd = { name = "+Dap" },
      g = { name = "+Goto" },
      gh = { name = "+Hierarchy" },
      t = { name = "+Test" },
      ["]"] = { name = "+Next" },
      ["["] = { name = "+Prev" },
      ["<leader>l"] = { name = "+Packager" },
      ["<leader>c"] = { name = "+Code" },
      ["<leader>t"] = { name = "+Task" },
      ["<leader>v"] = { name = "+VCS" },
      ["<leader>x"] = { name = "+Diagnostics" },
      ["<leader>w"] = { name = "+Workspace" },
    }
  end,
}
