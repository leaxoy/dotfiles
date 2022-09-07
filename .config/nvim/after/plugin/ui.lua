require("dressing").setup({
  input = { enabled = true, prompt_align = "center", winhighlight = "NormalFloat:Normal" },
  select = { enabled = true },
})

require("nvim-web-devicons").setup({ default = true })

-- tokyonight config
vim.g.tokyonight_style = "night"
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_sidebars = { "qf", "lspsagaoutline", "terminal", "packer", "toggleterm" }
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_colors = {}
vim.g.tokyonight_day_brightness = 0.3
vim.g.tokyonight_lualine_bold = true -- default false

local vscode_status, vscode = pcall(require, "vscode")
if vscode_status then
  vscode.setup({
    transparent = true,
    italic_comments = true,
    disable_nvimtree_bg = false,
  })
end

local catppuccin_status, catppuccin = pcall(require, "catppuccin")
if catppuccin_status then
  local colors = require("catppuccin.palettes").get_palette()
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
  catppuccin.setup({
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    transparent_background = true,
    term_colors = true,
    compile = {
      enabled = true,
      path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      coc_nvim = false,
      lsp_trouble = false,
      cmp = true,
      lsp_saga = true,
      gitgutter = false,
      gitsigns = true,
      leap = false,
      telescope = true,
      nvimtree = { enabled = true, show_root = true, transparent_panel = false, },
      neotree = { enabled = false, show_root = true, transparent_panel = false, },
      dap = { enabled = true, enable_ui = true, },
      which_key = true,
      indent_blankline = { enabled = true, colored_indent_levels = true, },
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = false,
      notify = true,
      telekasten = true,
      symbols_outline = true,
      mini = false,
      aerial = false,
      vimwiki = true,
      beacon = true,
      navic = false,
      overseer = false,
      fidget = true,
    },
    color_overrides = {},
    custom_highlights = {
      Normal = { fg = "NONE" },
      NormalFloat = { link = "Normal" },
      Comment = { italic = true },
      -- FloatTitle = { link = "Normal" },
      -- FloatBorder = { link = "Normal" },
      LspInlayHint = { link = "Comment" },
      LspFloatWinNormal = { link = "Normal" },

      CursorLine = { link = "CursorColumn" },

      Pmenu = { link = "Normal" },

      WhichKeyFloat = { link = "Normal" },

      LspCodeLens = { link = "WarningMsg" },
      LspCodeLensText = { link = "WarningMsg" },
      LspCodeLensTextSign = { link = "WarningMsg" },
      LspCodeLensTextSeparator = { link = "Boolean" },
    },
    highlight_overrides = {},
  })
end

local colorizer_status, colorizer = pcall(require, "colorizer")
if colorizer_status then colorizer.setup({ "*" }) end

vim.cmd.color(vim.g.theme or "habamax")
