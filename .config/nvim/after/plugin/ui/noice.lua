local status, noice = pcall(require, "noice")
if not status then return end

local function lsp_opts(title)
  return {
    border = { text = { top = title or "" } },
  }
end

noice.setup {
  cmdline = {
    format = {
      input = {
        opts = { relative = "cursor", position = { col = 1, row = 1 }, size = { min_width = 20 } },
      },
    },
  },
  lsp = {
    hover = { enabled = true, opts = lsp_opts "Hover" },
    signature = { enabled = true, opts = lsp_opts "Signature" },
    documentation = { view = "hover" },
  },
  messages = { enabled = true, view = false, view_warn = false, view_error = false },
  popupmenu = { backend = "nui" },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true,
  },
  views = {
    hover = {
      border = { style = "double", padding = { 0, 0, 0, 0 } },
      position = { row = 1, col = 1 },
    },
  },
}

vim.keymap.set("n", "fN", [[<CMD>Noice telescope<CR>]], { silent = true, desc = "Noice History" })
