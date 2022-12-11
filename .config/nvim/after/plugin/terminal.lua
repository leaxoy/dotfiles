local status, toggleterm = pcall(require, "toggleterm")
if not status then return end

toggleterm.setup {
  open_mapping = [[<c-t>]],
  size = function(term)
    if term.direction == "horizontal" then
      return 16
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  hidden = true,
  hide_numbers = true,
  -- direction = "tab",
  direction = "horizontal",
  shade_terminals = true,
  float_opts = { border = "double" },
}

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    buffer_keymap("t", "<Esc>", "<C-\\><C-n>")
    buffer_keymap("t", "jk", "<C-\\><C-n>")
  end,
})
