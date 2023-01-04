return {
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup {
        transparent = true,
        italic_comments = true,
        group_overrides = {
          Normal = { fg = "NONE" },
          NormalFloat = { link = "Normal" },
          Comment = { italic = true },
          TelescopeNormal = { link = "Normal" },
          TelescopeBorder = { link = "Normal" },
          FloatTitle = { link = "Normal" },
          FloatBorder = { link = "Normal" },
          FloatShadow = { link = "Normal" },
          FloatShadowThrough = { link = "Normal" },
          LspFloatWinNormal = { link = "Normal" },

          CursorLine = { link = "CursorColumn" },
          Cursor = { link = "Normal" },

          Pmenu = { link = "Normal" },

          WhichKeyFloat = { link = "Normal" },

          LspCodeLens = { link = "CursorLineFold" },
          LspCodeLensText = { link = "CursorLineFold" },
          LspCodeLensTextSign = { link = "CursorLineFold" },
          LspCodeLensTextSeparator = { link = "Boolean" },
        },
      }
    end,
  },
}
