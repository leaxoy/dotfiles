local dressing_status, dressing = pcall(require, "dressing")
if dressing_status then
  dressing.setup {
    input = { enabled = true, prompt_align = "center", winblend = 0 },
    select = {
      enabled = true,
      telescope = require("telescope.themes").get_dropdown { initial_mode = "normal" },
    },
  }
end

local vscode_status, vscode = pcall(require, "vscode")
if vscode_status then
  vscode.setup {
    transparent = true,
    italic_comments = true,
    disable_nvimtree_bg = false,
  }
end

local catppuccin_status, catppuccin = pcall(require, "catppuccin")
if catppuccin_status then
  catppuccin.setup {
    dim_inactive = { enabled = false, shade = "dark", percentage = 0.15 },
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
      cmp = true,
      dap = { enabled = true, enable_ui = true },
      dashboard = true,
      gitsigns = true,
      indent_blankline = { enabled = true, colored_indent_levels = true },
      lsp_saga = true,
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
      noice = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      which_key = true,
      vim_sneak = false,
      mason = true,
      markdown = true,
      notify = true,
      overseer = true,
    },
    color_overrides = {},
    custom_highlights = {
      Normal = { fg = "NONE" },
      NormalFloat = { link = "Normal" },
      Comment = { italic = true },
      FloatTitle = { link = "Normal" },
      FloatBorder = { link = "Normal" },
      FloatShadow = { link = "Normal" },
      FloatShadowThrough = { link = "Normal" },
      -- LspInlayHint = { link = "Comment" },
      LspFloatWinNormal = { link = "Normal" },

      CursorLine = { link = "CursorColumn" },

      Pmenu = { link = "Normal" },

      WhichKeyFloat = { link = "Normal" },

      LspCodeLens = { link = "Comment" },
      LspCodeLensText = { link = "Comment" },
      LspCodeLensTextSign = { link = "Comment" },
      LspCodeLensTextSeparator = { link = "Boolean" },
    },
    highlight_overrides = {},
  }

  vim.api.nvim_create_autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function()
      vim.cmd "CatppuccinCompile"
      vim.defer_fn(function() vim.cmd.color "catppuccin" end, 0) -- Defered for live reloading
    end,
  })
end

local colorizer_status, colorizer = pcall(require, "colorizer")
if colorizer_status then
  colorizer.setup { filetypes = { "*", "!tsx", "!jsx", "!html", "!css" } }
end

vim.cmd.color(vim.g.theme or "habamax")

local status, icons = pcall(require, "nvim-web-devicons")
if status then icons.setup {} end
