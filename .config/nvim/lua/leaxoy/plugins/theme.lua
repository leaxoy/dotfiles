return {
  -- {
  --   "Mofiqul/vscode.nvim",
  --   config = function()
  --     require("vscode").setup {
  --       transparent = true,
  --       italic_comments = true,
  --       group_overrides = {
  --         Normal = { fg = "NONE" },
  --         NormalFloat = { link = "Normal" },
  --         Comment = { italic = true },
  --         TelescopeNormal = { link = "Normal" },
  --         TelescopeBorder = { link = "Normal" },
  --         FloatTitle = { link = "Normal" },
  --         FloatBorder = { link = "Normal" },
  --         FloatShadow = { link = "Normal" },
  --         FloatShadowThrough = { link = "Normal" },
  --         LspFloatWinNormal = { link = "Normal" },
  --
  --         CursorLine = { link = "CursorColumn" },
  --         Cursor = { link = "Normal" },
  --
  --         WhichKeyFloat = { link = "Normal" },
  --
  --         LspCodeLens = { link = "CursorLineFold" },
  --         LspCodeLensText = { link = "CursorLineFold" },
  --         LspCodeLensTextSign = { link = "CursorLineFold" },
  --         LspCodeLensTextSeparator = { link = "Boolean" },
  --       },
  --     }
  --   end,
  -- },
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_background = "dark"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_cursor = "auto"
      vim.g.gruvbox_material_transparent_background = 2
      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_visual = "reverse"
      vim.g.gruvbox_material_menu_selection_background = "grey"
      vim.g.gruvbox_material_sign_column_background = "none"
      vim.g.gruvbox_material_spell_foreground = "colored"
      vim.g.gruvbox_material_ui_contrast = "high" -- or low
      vim.g.gruvbox_material_show_eob = 0
      vim.g.gruvbox_material_better_performance = 1
      local hl = vim.api.nvim_set_hl
      hl(0, "NormalFloat", { link = "Normal" })
      vim.cmd [[colorscheme gruvbox-material]]
    end,
  },
}
