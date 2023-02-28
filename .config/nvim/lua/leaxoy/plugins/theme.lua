local highlights = {
  --#region nvim builtin
  Normal = { fg = "NONE" },
  NormalFloat = { link = "Normal" },
  Cursor = { link = "Normal" },
  SignColumn = { link = "Normal" },
  --#endregion

  --#region Lsp
  -- LspReferenceText = { default = true },
  -- LspReferenceRead = { default = true },
  -- LspReferenceWrite = { default = true },
  LspCodeLens = { link = "@comment" },
  LspCodeLensSeparator = { link = "@comment" },
  -- LspSignatureActiveParameter = { default = true },
  LspInfoBorder = { link = "Normal" },
  --#endregion

  --#region Noice
  NoiceCmdlineIcon = { link = "Normal" },
  NoiceCmdlineIconSearch = { link = "NoiceCmdlineIcon" },
  -- NoiceCmdlinePopup = { link = "Pmenu" },
  NoiceCmdlinePopupBorder = { link = "Normal" },
  NoiceCmdlinePopupBorderSearch = { link = "NoiceCmdlinePopupBorder" },
  NoicePopup = { link = "Pmenu" },
  --#endregion

  --#region Lspsaga
  TitleString = { link = "Pmenu" },
  TitleIcon = { link = "Pmenu" },
  SagaNormal = { link = "Pmenu" },
  SagaBorder = { link = "Pmenu" },
  FinderSelection = { link = "Pmenu" },
  FinderFileName = { link = "Pmenu" },
  FinderCount = { link = "Label" },
  FinderIcon = { link = "@keyword" },
  FinderType = { link = "Pmenu" },
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
    opts = {
      transparent = true,
      italic_comments = true,
      group_overrides = highlights,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      local overrides = vim.tbl_extend("force", highlights, {
        GitSignsAdd = { link = "GruvboxGreen" },
        GitSignsChange = { link = "GruvboxAqua" },
        GitSignsDelete = { link = "GruvboxRed" },

        DiagnosticSignWarn = { link = "GruvboxYellow" },
        DiagnosticSignInfo = { link = "GruvboxBlue" },
        DiagnosticSignHint = { link = "GruvboxAqua" },
        DiagnosticSignError = { link = "GruvboxRed" },
      })
      require("gruvbox").setup {
        overrides = overrides,
        contrast = "hard",
      }
      require("gruvbox").load()
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").load {
        light_style = "day",
        style = "night",
        -- transparent = true,
        ---@diagnostic disable-next-line: unused-local
        on_highlights = function(h, colors)
          for name, hl in pairs(highlights) do
            h[name] = hl
          end
        end,
        styles = { sidebars = "normal" },
        sidebars = {},
        use_background = true,
      }
    end,
  },
}
