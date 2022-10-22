local status, noice = pcall(require, "noice")
if not status then return end

noice.setup {
  lsp_progress = { enabled = true },
  messages = { enabled = true, view = false, view_warn = false, view_error = false },
  popupmenu = { backend = "cmp" },
}

vim.keymap.set(
  "n",
  "fN",
  [[<CMD>Noice telescope<CR>]],
  { noremap = true, silent = true, desc = "Noice History" }
)
