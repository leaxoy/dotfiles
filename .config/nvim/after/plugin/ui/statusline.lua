local status, lualine = pcall(require, "lualine")
if not status then return end

lualine.setup {
  options = {
    theme = "auto",
    icon_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    always_divide_middle = false,
    globalstatus = true,
  },
  extensions = { "nvim-tree", "toggleterm", "quickfix", "neo-tree" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      { "diff", symbols = { added = " ", modified = " ", removed = " " } },
    },
    lualine_c = {
      {
        function()
          local msg = "[None]"
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then return msg end
          local names = {}
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if
              filetypes
              and vim.fn.index(filetypes, vim.bo.filetype) ~= -1
              and not vim.tbl_contains(names, client.name)
            then
              table.insert(names, client.name)
            end
          end
          table.sort(names)
          return names and table.concat(names, " & ") or msg
        end,
        icon = "",
        color = { fg = "#006611", gui = "bold" },
      },
    },
    lualine_x = {},
    lualine_y = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
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
    lualine_z = { "progress", "location" },
  },
}
