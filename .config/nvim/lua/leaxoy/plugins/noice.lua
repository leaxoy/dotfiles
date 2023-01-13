return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  enabled = false,
  config = function()
    require("noice").setup {
      cmdline = { opts = { size = { min_width = 20 } } },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = { enabled = false },
      popupmenu = { backend = "nui" },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
      },
      views = {
        hover = {
          border = { padding = { 0, 0 } },
          size = { max_width = 80, max_height = 16 },
          position = { row = 1, col = 0 },
        },
      },
    }
  end,
}
