local status, lualine = pcall(require, "lualine")
if not status then return end

lualine.setup({
  options = {
    theme = "auto",
    icon_enabled = true,
    component_separators = { left = "", right = "", },
    section_separators = { left = "", right = "" },
    always_divide_middle = false,
    globalstatus = true,
  },
  extensions = { "nvim-tree", "toggleterm", "quickfix" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "filename", file_status = true, path = 1 } },
    lualine_c = {},
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        -- symbols = { error = " ", warn = " ", hint = " ", info = " " },
        -- symbols = { error = " ", warn = " ", info = " " },
        symbols = { error = " ", warn = " ", hint = " ", info = " " },
        diagnostics_color = {
          -- Same values like general color option can be used here.
          error = "DiagnosticError", -- changes diagnostic's error color
          warn = "DiagnosticWarn", -- changes diagnostic's warn color
          info = "DiagnosticInfo", -- Changes diagnostic's info color
          hint = "DiagnosticHint", -- Changes diagnostic's hint color
        },
        colored = true,
      },
    },
    lualine_y = { "diff", "branch" },
    lualine_z = { "progress", "location" },
  },
})
