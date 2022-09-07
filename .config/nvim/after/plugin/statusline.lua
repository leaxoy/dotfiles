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
  extensions = { "nvim-tree", "toggleterm", "quickfix", "neo-tree" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "filename", file_status = true, path = 1 } },
    lualine_c = {
      { "%=" },
      {
        function()
          local msg = "[None]"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then return msg end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
          end
          return msg
        end,
        icon = " LSP:",
        color = { fg = "#006611", gui = "bold" },
      }
    },
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
    lualine_y = { { "diff", symbols = { added = " ", modified = " ", removed = " " } }, "branch" },
    lualine_z = { "progress", "location" },
  },
})
