require("toggleterm").setup({
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
})
