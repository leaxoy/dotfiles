return {
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      ---@class Shortcut
      ---@field icon string
      ---@field icon_hl string|nil
      ---@field desc string
      ---@field desc_hl string|nil
      ---@field key string
      ---@field key_hl string|nil
      ---@field keymap string|nil
      ---@field action string|fun()
      ---@param shortcut Shortcut
      ---@return Shortcut
      local function key(shortcut)
        shortcut.icon_hl = shortcut.icon_hl or "Title"
        shortcut.desc_hl = shortcut.desc_hl or "String"
        shortcut.key_hl = shortcut.key_hl or "Keyword"
        return shortcut
      end
      require("dashboard").setup {
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
            key { icon = "  ", desc = "Telescopes", key = "fw", action = "Telescope" },
            key { icon = "  ", desc = "Find File", key = "ff", action = "Telescope find_files" },
            key { icon = "  ", desc = "Explorer", key = "fl", action = "Telescope file_browser" },
            key { icon = "  ", desc = "Find Word", key = "fg", action = "Telescope live_grep" },
            key { icon = "  ", desc = "Help", key = "fh", action = "Telescope help_tags" },
          },
          footer = { "🎉 No Code, No Bug 🎉" },
        },
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function() vim.g.neo_tree_remove_legacy_commands = 1 end,
    keys = {
      { [[\\]], "<CMD>Neotree toggle<CR>", desc = "Toggle file explorer" },
    },
    config = function()
      require("neo-tree").setup {
        default_component_configs = {
          icon = { folder_closed = "", folder_open = "", folder_empty = "" },
          git_status = {
            symbols = {
              added = "",
              modified = "",
              deleted = "",
              renamed = "",

              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "",
              conflict = "",
            },
          },
        },
        source_selector = { winbar = true },
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    ---@type NoiceConfig
    opts = {
      cmdline = { opts = { size = { min_width = 20 } } },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = { enabled = false },
      popupmenu = { backend = "cmp", kind_icons = vim.lsp.protocol.CompletionItemKind },
      presets = {
        bottom_search = false,
        command_palette = true,
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
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@type Options
    opts = {
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
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "▸", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = { scroll_down = "<c-d>", scroll_up = "<c-u>" },
      window = {
        -- border = "rounded", -- none, single, double, shadow
        -- position = "bottom", -- bottom, top
        -- margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        -- winblend = 0,
      },
      layout = {
        height = { min = 2, max = 16 }, -- min and max height of the columns
        width = { min = 10, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      show_keys = true,
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)
      wk.register {
        mode = { "n", "v" },
        f = { name = "+Finder" },
        g = { name = "+Goto" },
        gh = { name = "+Hierarchy" },
        t = { name = "+Test" },
        ["\\"] = { name = "+Toggle" },
        ["]"] = { name = "+Next" },
        ["["] = { name = "+Prev" },
        ["<leader>l"] = { name = "+Package" },
        ["<leader>c"] = { name = "+Code" },
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
    init = function()
      local function cb() map_local { "<Esc>", [[<C-\><C-n>]], mode = "t" } end
      vim.api.nvim_create_autocmd("TermOpen", { pattern = "term://*", callback = cb })

      local function gitui()
        if not vim.fn.executable "gitui" then return end
        local git = require("toggleterm.terminal").Terminal:new { cmd = "gitui" }
        git:toggle()
      end
      map { "<leader>vv", gitui, desc = "GitUI" }
    end,
    ---@type ToggleTermConfig
    opts = {
      open_mapping = [[<c-t>]],
      size = 16,
      hidden = true,
      hide_numbers = true,
      direction = "horizontal",
      shade_terminals = false,
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    init = function()
      local fn = vim.fn

      function _G.qftf(info)
        local items
        local ret = {}
        -- The name of item in list is based on the directory of quickfix window.
        -- Change the directory for quickfix window make the name of item shorter.
        -- It's a good opportunity to change current directory in quickfixtextfunc :)
        --
        -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
        -- local root = getRootByAlterBufnr(alterBufnr)
        -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
        --
        if info.quickfix == 1 then
          items = fn.getqflist({ id = info.id, items = 0 }).items
        else
          items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
        end
        local limit = 31
        local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
        local validFmt = "%s │%4d:%-3d│%s %s"
        for i = info.start_idx, info.end_idx do
          local e = items[i]
          local fname = ""
          local str
          if e.valid == 1 then
            if e.bufnr > 0 then
              fname = fn.bufname(e.bufnr)
              if fname == "" then
                fname = "[No Name]"
              else
                fname = fname:gsub("^" .. vim.loop.cwd(), "")
              end
              -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
              if #fname <= limit then
                fname = fnameFmt1:format(fname)
              else
                fname = fnameFmt2:format(fname:sub(1 - limit))
              end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
          else
            str = e.text
          end
          table.insert(ret, str)
        end
        return ret
      end

      vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
    end,
    ---@type BqfConfig
    opts = {
      auto_enable = true,
      auto_preview = true,
      auto_resize_height = true,
      magic_window = true,
      preview = { auto_preview = true, show_title = true },
      filter = {
        fzf = { extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" } },
      },
    },
  },
  {
    "uga-rosa/ccc.nvim",
    event = "BufReadPost",
    opts = {
      highlighter = {
        auto_enable = true,
      },
    },
    config = function(_, opts)
      local cc = require "ccc"
      local picker = cc.picker
      opts.pickers = {
        picker.hex,
        picker.css_rgb,
        picker.css_hsl,
        picker.css_hwb,
        picker.css_lab,
        picker.css_lch,
        picker.css_oklab,
        picker.css_oklch,
        picker.css_name,
      }
      cc.setup(opts)
    end,
  },
}
