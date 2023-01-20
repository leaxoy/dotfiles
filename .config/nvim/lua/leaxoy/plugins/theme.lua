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
  LspCodeLens = { link = "@comment" },
  LspCodeLensSeparator = { link = "@comment" },
  -- LspSignatureActiveParameter = { default = true },
  --#endregion
}

return {
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    enabled = false,
    config = function()
      require("vscode").setup {
        transparent = true,
        italic_comments = true,
        group_overrides = highlights,
      }
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
          neotest = true,
          noice = true,
          notify = true,
          overseer = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = false,
    config = function()
      require("tokyonight").setup {
        use_background = "auto",
        -- style = "night",
        -- light_style = "day",
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
