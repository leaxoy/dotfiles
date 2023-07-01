---@type Highlights
local highlights = {
  ---#region nvim builtin
  Normal = { fg = "NONE" },
  NormalFloat = { link = "Normal" },
  Cursor = { link = "Normal" },
  SignColumn = { link = "Normal" },
  --#endregion

  --#region Lsp
  LspReferenceText = { default = true },
  LspReferenceRead = { default = true },
  LspReferenceWrite = { default = true },
  LspCodeLens = { link = "@comment" },
  LspCodeLensSeparator = { link = "@comment" },
  LspSignatureActiveParameter = { default = true },
  LspInfoBorder = { link = "Normal" },
  LspInlayHint = { link = "Pmenu", reverse = true },
  --#endregion

  --#region Lsp semantic token
  ["@lsp.mod.defaultLibrary"] = { bold = true },
  ["@lsp.mod.deprecated"] = { strikethrough = true },
  ["@lsp.mod.mutable"] = { link = "DiagnosticUnderlineOk" },
  ["@lsp.mod.readonly"] = { link = "@constant" },
  ["@lsp.type.keyword"] = { italic = true },
  ["@lsp.type.namespace"] = { link = "@namespace" },
  ["@lsp.type.parameter"] = { link = "@parameter" },
  ["@lsp.type.variable"] = { link = "@variable" },
  --#endregion
  CmpItemAbbrDeprecated = { link = "@lsp.mod.deprecated" },
  CmpItemAbbrDeprecatedDefault = { strikethrough = true },

  --#region Noice
  NoiceCmdlineIcon = { link = "Normal" },
  NoiceCmdlineIconSearch = { link = "NoiceCmdlineIcon" },
  NoiceCmdlinePopup = { link = "Pmenu" },
  NoiceCmdlinePopupBorder = { link = "Normal" },
  NoiceCmdlinePopupBorderSearch = { link = "NoiceCmdlinePopupBorder" },
  NoicePopup = { link = "Pmenu" },
  --#endregion

  MasonNormal = { link = "Pmenu", default = true },

  LazyNormal = { link = "Pmenu", default = true },

  --#region Lspsaga
  TitleString = { link = "Pmenu" },
  TitleIcon = { link = "Pmenu" },
  SagaNormal = { link = "Pmenu" },
  SagaBorder = { link = "Pmenu" },
  FinderSelection = { link = "Pmenu" },
  FinderFileName = { link = "Pmenu" },
  FinderBorder = { bg = "NONE" },
  FinderPreviewBorder = { bg = "NONE" },
  FinderCount = { link = "Label" },
  FinderIcon = { link = "@keyword" },
  FinderType = { link = "Pmenu" },
  FinderTips = { link = "@keyword" },
  ActionPreviewTitle = { link = "Pmenu" },
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
    "ellisonleao/gruvbox.nvim",
    config = function()
      local contrast = ""
      local base16_theme = vim.env.BASE16_THEME or ""
      local function find(s, p) return string.find(s, p) and true or false end
      if find(base16_theme, "gruvbox") then
        if find(base16_theme, "light") then vim.opt.background = "light" end
        if find(base16_theme, "hard") then
          contrast = "hard"
        elseif string.find(base16_theme, "soft") then
          contrast = "soft"
        end
      end
      local overrides = vim.tbl_extend("force", highlights, {
        GitSignsAdd = { link = "GruvboxGreen" },
        GitSignsChange = { link = "GruvboxAqua" },
        GitSignsDelete = { link = "GruvboxRed" },
        DiagnosticSignWarn = { link = "GruvboxYellow" },
        DiagnosticSignInfo = { link = "GruvboxBlue" },
        DiagnosticSignHint = { link = "GruvboxAqua" },
        DiagnosticSignError = { link = "GruvboxRed" },
        ["@lsp.type.typeParameter"] = { link = "GruvboxPurple" },
      })
      require("gruvbox").setup {
        overrides = overrides,
        contrast = contrast,
        transparent_mode = true,
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
        ---@diagnostic disable-next-line: unused-local
        on_highlights = function(h, _)
          vim.iter(highlights):each(function(name, hi) h[name] = hi end)
        end,
        styles = { sidebars = "normal" },
        sidebars = {},
        use_background = true,
      }
    end,
  },
}
