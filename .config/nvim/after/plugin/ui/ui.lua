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

local tokyo_status, tokyo = pcall(require, "tokyonight")
if tokyo_status then
  tokyo.setup {
    style = "night",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param hl Highlights
    ---@param c ColorScheme
    on_highlights = function(hl, c)
      hl.Normal = { fg = "NONE" }
      hl.NormalFloat = { link = "Normal" }
      hl.Comment = { italic = true }
      hl.FloatTitle = { link = "Normal" }
      hl.FloatBorder = { link = "Normal" }
      hl.FloatShadow = { link = "Normal" }
      hl.FloatShadowThrough = { link = "Normal" }
      -- LspInlayHint = { link = "Comment" },
      hl.LspFloatWinNormal = { link = "Normal" }

      hl.CursorLine = { link = "CursorColumn" }

      hl.Pmenu = { link = "Normal" }

      hl.WhichKeyFloat = { link = "Normal" }

      hl.LspCodeLens = { link = "Comment" }
      hl.LspCodeLensText = { link = "Comment" }
      hl.LspCodeLensTextSign = { link = "Comment" }
      hl.LspCodeLensTextSeparator = { link = "Boolean" }
    end,
  }
end

local colorizer_status, colorizer = pcall(require, "colorizer")
if colorizer_status then
  colorizer.setup { filetypes = { "*", "!tsx", "!jsx", "!html", "!css" } }
end

vim.cmd.color(vim.g.theme or "habamax")
