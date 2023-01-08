---@type Highlights
local highlights = {
  Normal = { fg = "NONE" },
  NormalFloat = { link = "Normal" },
  FloatTitle = { link = "Normal" },
  FloatBorder = { link = "Normal" },
  CursorLine = { link = "CursorColumn" },
  Cursor = { link = "Normal" },

  --#region Telescope
  TelescopeNormal = { link = "Normal" },
  TelescopeBorder = { link = "Normal" },
  --#endregion

  --#region WhichKey
  WhichKeyFloat = { link = "Normal" },
  --#endregion

  --#region Lsp
  -- LspReferenceText = { default = true },
  -- LspReferenceRead = { default = true },
  -- LspReferenceWrite = { default = true },
  LspCodeLens = { link = "Comment" },
  LspCodeLensSeparator = { link = "Boolean" },
  -- LspSignatureActiveParameter = { default = true },
  --#endregion
}

return {
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup {
        transparent = true,
        italic_comments = true,
        group_overrides = highlights,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup {
        use_background = "auto",
        style = "night",
        light_style = "day",
        transparent = true,
        sidebars = {},
        styles = { sidebars = "normal", floats = "normal" },
        on_highlights = function(hl, colors)
          for name, highlight in pairs(highlights) do
            hl[name] = highlight
          end
        end,
      }
      require("tokyonight").load {}
    end,
  },
}
