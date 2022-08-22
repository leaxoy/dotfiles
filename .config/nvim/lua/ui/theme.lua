local hl = function(group, val) vim.api.nvim_set_hl(0, group, val) end

hl("WinBar", { fg = "#458e88", undercurl = true })
hl("WinBarNC", { fg = "#666777", undercurl = true })

-- gruvbox material config
vim.g.gruvbox_material_background = "hard" -- hard, medium or soft
vim.g.gruvbox_material_foreground = "material" -- material, mix or original
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_cursor = "auto"
vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_menu_selection_background = "grey"
-- vim.g.gruvbox_material_sign_column_background = "grey"
vim.g.gruvbox_material_spell_foreground = "colored"
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_show_eob = 0
vim.g.gruxbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_line_highlight = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_current_word = "grey background"
vim.g.gruvbox_material_disable_terminal_colors = 1
vim.g.gruvbox_material_statusline_style = "default"

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
      enabled = false,
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
      nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
      },
      neotree = {
        enabled = false,
        show_root = true,
        transparent_panel = false,
      },
      dap = {
        enabled = true,
        enable_ui = true,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
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
    },
    color_overrides = {},
    highlight_overrides = {},
  })
end

local colorizer_status, colorizer = pcall(require, "colorizer")
if colorizer_status then colorizer.setup({ "*" }) end

vim.cmd({ cmd = "colorscheme", args = { vim.g.theme or "habamax" } })
