local highlights = {
  --#region nvim builtin
  Normal = { fg = "NONE" },
  NormalFloat = { link = "Normal" },
  CursorLine = { link = "CursorColumn" },
  Cursor = { link = "Normal" },
  --#endregion

  --#region Lsp
  -- LspReferenceText = { default = true },
  -- LspReferenceRead = { default = true },
  -- LspReferenceWrite = { default = true },
  LspCodeLens = { link = "@comment" },
  LspCodeLensSeparator = { link = "@comment" },
  -- LspSignatureActiveParameter = { default = true },
  --#endregion

  --#region Noice
  NoiceCmdlinePopupBorder = { link = "Normal" },
  NoiceCmdlinePrompt = { link = "Normal" },
  NoicePopup = { link = "Pmenu" },
  --#endregion

  --#region Lspsaga
  SagaNormal = { link = "Pmenu" },
  SagaBorder = { link = "Pmenu" },
  --#endregion

  --#region Telescope
  TelescopeNormal = { link = "Normal" },
  TelescopeBorder = { link = "Normal" },
  --#endregion

  --#region WhichKey
  WhichKeyFloat = { link = "Pmenu" },
  --#endregion
}

return {
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      group_overrides = highlights,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("gruvbox").setup {
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = highlights,
        dim_inactive = false,
        transparent_mode = false,
      }
      vim.cmd.colorscheme "gruvbox"
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    build = ":CatppuccinCompile",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
        -- transparent_background = true,
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        term_colors = true,
        custom_highlights = highlights,
        integrations = {
          cmp = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
          dashboard = true,
          gitsigns = true,
          lsp_saga = true,
          mason = true,
          mini = true,
          neotest = true,
          noice = true,
          notify = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
