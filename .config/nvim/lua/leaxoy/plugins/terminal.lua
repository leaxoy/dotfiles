return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<C-t>", "<CMD>ToggleTerm<CR>" },
  },
  config = function()
    local toggleterm = (require "toggleterm")

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
      direction = "horizontal",
      shade_terminals = false,
    }

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function() buffer_keymap("t", "<Esc>", "<C-\\><C-n>") end,
    })

    if vim.fn.executable "gitui" then
      local git = require("toggleterm.terminal").Terminal:new { cmd = "gitui" }
      keymap("n", "<leader>vv", function() git:toggle() end, { desc = "Git UI" })
    end
  end,
}
