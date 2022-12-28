local code_status, code = pcall(require, "vscode")
if code_status then
  code.setup {
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
      LspInlayHint = { link = "Comment" },
      LspFloatWinNormal = { link = "Normal" },

      CursorLine = { link = "CursorColumn" },
      Cursor = { link = "Normal" },

      Pmenu = { link = "Normal" },

      WhichKeyFloat = { link = "Normal" },

      -- LspCodeLens = { link = "Comment" },
      -- LspCodeLensText = { link = "Comment" },
      -- LspCodeLensTextSign = { link = "Comment" },
      -- LspCodeLensTextSeparator = { link = "Boolean" },
    },
  }
end

local colorizer_status, colorizer = pcall(require, "colorizer")
if colorizer_status then
  colorizer.setup { filetypes = { "*", "!tsx", "!jsx", "!html", "!css" } }
end

vim.cmd.color(vim.g.theme or "habamax")
