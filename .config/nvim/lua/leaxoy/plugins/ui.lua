return {
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    opts = {
      theme = "doom",
      config = {
        header = {
          "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀",
          "⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀",
          "⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀",
          "⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀",
          "⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀",
          "⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⠀",
          "⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀",
          "⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀",
          "⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀",
          "⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀",
          "⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀",
          "⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        },
        center = {
          {
            icon = " ",
            desc = "Commands                          ",
            key = "  f w  ",
            action = "Telescope",
          },
          {
            icon = " ",
            desc = "Find File                         ",
            key = "  f f  ",
            action = "Telescope find_files",
          },
          {
            icon = " ",
            desc = "File Browser                      ",
            key = "  f l  ",
            action = "Telescope file_browser",
          },
          {
            icon = " ",
            desc = "Find Word                         ",
            key = "  f g  ",
            action = "Telescope live_grep",
          },
          {
            icon = " ",
            desc = "Help                              ",
            key = "  f h  ",
            action = "Telescope help_tags",
          },
        },
        footer = { "🎉 No Code, No Bug 🎉" },
      },
    },
  },
  {
    "feline-nvim/feline.nvim",
    event = "VeryLazy",
    config = function()
      local fe = require "feline"

      local components = { active = {} }

      ---@param opts table|nil
      local function hl_fn(opts) return vim.tbl_extend("force", { bg = "NONE" }, opts or {}) end

      components.active[1] = {
        { provider = "▊ ", hl = hl_fn { fg = "skyblue" } },
        {
          provider = "vi_mode",
          hl = function()
            return {
              name = require("feline.providers.vi_mode").get_mode_highlight_name(),
              fg = require("feline.providers.vi_mode").get_mode_color(),
              bg = "NONE",
              style = "bold",
            }
          end,
          right_sep = { " ", { str = "slant_right_2_thin", hl = hl_fn { fg = "fg" } } },
        },
        { provider = "git_branch", hl = hl_fn { fg = "cyan", style = "bold" }, icon = "  " },
        { provider = "git_diff_added", hl = hl_fn { fg = "green" }, icon = "  " },
        { provider = "git_diff_removed", hl = hl_fn { fg = "red" }, icon = "  " },
        { provider = "git_diff_changed", hl = hl_fn { fg = "orange" }, icon = "  " },
      }

      components.active[2] = {
        {
          provider = function()
            local clients = {}

            for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
              clients[#clients + 1] = client.name
            end
            table.sort(clients)

            return table.concat(clients, " & ")
          end,
          hl = hl_fn { fg = "teal" },
          icon = " ",
        },
      }

      components.active[3] = {
        { provider = "search_count", hl = hl_fn { fg = "lightblue" }, icon = " " },
        {
          provider = function() return require("lazy.status").updates() .. " Plugin Updates" end,
          hl = hl_fn { fg = "magenta" },
          right_sep = { { str = " ", hl = hl_fn {} } },
          enabled = require("lazy.status").has_updates,
        },
        { provider = "diagnostic_errors", hl = hl_fn { fg = "red" }, icon = "  " },
        { provider = "diagnostic_warnings", hl = hl_fn { fg = "yellow" }, icon = "  " },
        { provider = "diagnostic_hints", hl = hl_fn { fg = "cyan" }, icon = "  " },
        { provider = "diagnostic_info", hl = hl_fn { fg = "skyblue" }, icon = "  " },
        {
          provider = "position",
          hl = hl_fn { fg = "orange" },
          icon = " ",
          left_sep = { { str = " ", hl = hl_fn {} } },
          right_sep = { { str = " ", hl = hl_fn {} } },
        },
        { provider = "scroll_bar", hl = hl_fn { fg = "skyblue", style = "bold" } },
      }

      fe.setup {
        components = components,
        conditional_components = {},
        custom_providers = {},
        theme = {},
        separators = {},
        force_inactive = {},
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup {
        cmdline = { opts = { size = { min_width = 20 } } },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        messages = { enabled = false },
        popupmenu = { backend = "nui" },
        presets = {
          bottom_search = false,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = true,
        },
        views = {
          hover = {
            border = { padding = { 0, 1 } },
            size = { max_width = 80, max_height = 16 },
            position = { row = 1, col = 0 },
          },
        },
      }
    end,
  },
  {
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
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-t>", [[<CMD>execute v:count . "ToggleTerm"<CR>]] },
    },
    config = function()
      local toggleterm = (require "toggleterm")

      toggleterm.setup {
        open_mapping = [[<c-t>]],
        size = function(term)
          if term.direction == "horizontal" then
            return 16
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        hidden = true,
        hide_numbers = true,
        direction = "horizontal",
        shade_terminals = false,
      }

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function() map_local { "<Esc>", "<C-\\><C-n>" } end,
      })
    end,
  },
}
