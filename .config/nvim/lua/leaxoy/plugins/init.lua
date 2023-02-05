return {
  {
    "folke/lazy.nvim",
    init = function()
      map { "<leader>lp", "<CMD>Lazy<CR>", desc = "Manage Plugins" }
      map { "<leader>wu", "<CMD>Lazy sync<CR>", desc = "Update Plugins" }
    end,
  },

  {
    "echasnovski/mini.basics",
    opts = {
      options = {
        basic = true,
      },
      mappings = {
        basic = true,
        windows = true,
      },
      autocommands = {},
    },
    config = function(_, opts) require("mini.basics").setup(opts) end,
  },

  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function() require("notify").setup { background_colour = "#000000" } end,
  },
  { "mfussenegger/nvim-jdtls", lazy = true },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    ---@type LazyKeys[]
    keys = {
      { "[T", [[<CMD>lua require("todo-comments").jump_prev()<CR>]], desc = "Prev Todo" },
      { "]T", [[<CMD>lua require("todo-comments").jump_next()<CR>]], desc = "Next Todo" },
    },
    opts = {
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "fixme", "bug" } },
        TODO = { icon = " ", color = "info", alt = { "todo" } },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
        TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufReadPost",
    opts = {
      code_generation = {},
      formatting = {},
      extract_var_statements = {},
      printf_statements = {},
      print_var_statements = {},
      prompt_func_return_type = { go = true, java = true, python = true },
      prompt_func_param_type = { go = true, java = true, python = true },
    },
  },

  {
    "folke/neoconf.nvim",
    priority = 1000,
    cmd = "Neoconf",
    keys = {
      { "<leader>w,", [[<CMD>Neoconf global<CR>]], desc = "Global Settings" },
      { "<leader>w.", [[<CMD>Neoconf local<CR>]], desc = "Local Settings" },
    },
    config = true,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    ---@type LazyKeys[]
    keys = {
      { "<leader>lm", "<CMD>Mason<CR>", desc = "Manage Mason" },
    },
    opts = {
      ---@type table<string, string|string[]>
      dependencies = {},
    },
    config = function(_, opts)
      require("mason").setup {
        ui = {
          border = "double",
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      }

      local registry = require "mason-registry"
      for _, dependence in pairs(opts.dependencies) do
        local pkg = registry.get_package(dependence)
        if not pkg:is_installed() then pkg:install {} end
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    cmd = "Gitsigns",
    ---@type LazyKeys[]
    keys = {
      { "<leader>vd", "<CMD>Gitsigns diffthis<CR>", desc = "Diff This Hunk" },
      { "<leader>vp", "<CMD>Gitsigns preview_hunk_inline<CR>", desc = "Preview Diff" },
      { "[h", "<CMD>Gitsigns prev_hunk<CR>", desc = "Previous hunk" },
      { "]h", "<CMD>Gitsigns next_hunk<CR>", desc = "Next hunk" },
    },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 150 },
      yadm = { enable = true },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggle",
      "DiffviewFileHistory",
    },
    ---@type LazyKeys[]
    keys = {
      { "<leader>vh", "<CMD>DiffviewFileHistory<CR>", desc = "History" },
      { "<leader>vD", "<CMD>DiffviewToggle<CR>", desc = "Toggle" },
    },
    ---@type DiffViewOptions
    opts = {
      icons = {
        folder_closed = " ",
        folder_open = " ",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = " ",
      },
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_user_command("DiffviewToggle", function(e)
        local view = require("diffview.lib").get_current_view()
        vim.cmd(view and "DiffviewClose" or "DiffviewOpen " .. e.args)
      end, { desc = "Toggle Diffview" })
      require("diffview").setup(opts)
    end,
  },

  {
    "luukvbaal/statuscol.nvim",
    enabled = has "nvim-0.9",
    config = function()
      local function click_diagnostic(args)
        if args.button == "l" then
          vim.cmd [[Lspsaga show_line_diagnostics]]
        elseif args.button == "r" then
          vim.lsp.buf.code_action()
        end
      end

      local function start_run(args)
        if args.button == "l" then vim.lsp.codelens.run() end
      end

      require("statuscol").setup {
        setopt = true,
        DiagnosticSignError = click_diagnostic,
        DiagnosticSignHint = click_diagnostic,
        DiagnosticSignInfo = click_diagnostic,
        DiagnosticSignWarn = click_diagnostic,
        CodelensRun = start_run,
        CodelensDebug = start_run,
      }
    end,
  },

  { "christoomey/vim-tmux-navigator" },

  {
    "axieax/urlview.nvim",
    command = "UrlView",
    ---@type LazyKeys[]
    keys = {
      { "fu", "<CMD>UrlView<CR>", desc = "Lookup buffer links" },
      { "[u", [[<CMD>lua require("urlview.jump").prev_url()<CR>]], desc = "Previous link" },
      { "]u", [[<CMD>lua require("urlview.jump").next_url()<CR>]], desc = "Next link" },
    },
    config = function(_, opts) require("urlview").setup(opts) end,
  },
}
