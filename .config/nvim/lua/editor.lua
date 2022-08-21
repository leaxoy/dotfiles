local function setup_edit()
  require("Comment").setup({ mappings = { extra = false } })
  require("todo-comments").setup({
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info", alt = { "todo" } },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
    },
  })
  require("nvim-autopairs").setup({})
end

local function setup_treesitter()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.org = {
    install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      revision = "main",
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "org",
  }

  require("nvim-treesitter.configs").setup({
    ensure_installed = vim.g.ts_syntaxes,
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = { "org" },
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
    },
  })
end

local function setup_diagnostic()
  vim.diagnostic.config({
    virtual_text = {
      prefix = "", -- Could be '●', '▎', 'x', "■"
      source = "if_many",
      severity = {
        min = vim.diagnostic.severity.ERROR,
      }
    },
    signs = true,
    underline = {
      severity = {
        min = vim.diagnostic.severity.WARN,
      }
    },
    float = { show_header = true, focus = false, border = "double" },
    update_in_insert = true,
    severity_sort = false,
  })

  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

local function setup_keyx()
  require("which-key").setup {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = { enabled = true, suggestions = 20 },
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    operators = { gc = "Comments" },
    key_labels = { ["<space>"] = "SPC", ["<cr>"] = "RET", ["<tab>"] = "TAB" },
    icons = { breadcrumb = "»", separator = "ﲖ", group = "+" },
    popup_mappings = { scroll_down = "<c-d>", scroll_up = "<c-u>" },
    window = {
      border = "double", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
  }
end

setup_edit()
setup_treesitter()
setup_diagnostic()
setup_keyx()
