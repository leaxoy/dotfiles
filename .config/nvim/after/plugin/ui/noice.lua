local status, noice = pcall(require, "noice")
if not status then return end

noice.setup {
  cmdline = { opts = { size = { min_width = 20 } } },
  lsp = {
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = true,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = true,
    },
  },
  messages = { enabled = true, view = false, view_warn = false, view_error = false },
  popupmenu = { backend = "nui" },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true,
    -- lsp_doc_border = true,
  },
  -- views = {
  --   hover = { border = { padding = { 0, 2 } } },
  -- },
}

vim.keymap.set("n", "fN", [[<CMD>Noice telescope<CR>]], { silent = true, desc = "Noice History" })
