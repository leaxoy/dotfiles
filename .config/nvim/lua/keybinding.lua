-- Window
keymap("nv", "<M-h>", "<c-w>10<", { desc = "Decrease Width" })
keymap("nv", "<M-l>", "<c-w>10>", { desc = "Increase Width" })
keymap("nv", "<M-j>", "<c-w>4+", { desc = "Increase Height" })
keymap("nv", "<M-k>", "<c-w>4-", { desc = "Decrease Height" })
keymap("nv", "<M-=>", "<c-w>=", { desc = "Equally high and wide" })
keymap("nvt", "<C-h>", cmd_fn("wincmd", { "h" }), { desc = "Goto Left Window" })
keymap("nvt", "<C-l>", cmd_fn("wincmd", { "l" }), { desc = "Goto Right Window" })
keymap("nvt", "<C-j>", cmd_fn("wincmd", { "j" }), { desc = "Goto Bottom Window" })
keymap("nvt", "<C-k>", cmd_fn("wincmd", { "k" }), { desc = "Goto Top Window" })

--- Cursor Movement
keymap("i", "<C-h>", "<Left>", { desc = "Move Cursor Left" })
keymap("i", "<C-j>", "<Down>", { desc = "Move Cursor Down" })
keymap("i", "<C-k>", "<Up>", { desc = "Move Cursor Up" })
keymap("i", "<C-l>", "<Right>", { desc = "Move Cursor Right" })

-- LSP or DAP or Linter or Formatter
keymap("n", "<leader>l", partial(show_keymap, "<leader>l"), { desc = "+Mason" })
keymap("n", "<leader>lm", cmd_fn "Mason", { desc = "Manage Mason" })
keymap("n", "<leader>lr", cmd_fn "LspRestart", { desc = "Restart LSP" })
keymap("n", "<leader>li", cmd_fn "LspInfo", { desc = "Show Server Info" })
keymap("n", "<leader>ln", cmd_fn "NullLsInfo", { desc = "Show NullLs Info" })

-- VCS
keymap("n", "<leader>v", partial(show_keymap, "<leader>v"), { desc = "+VCS" })
keymap("n", "<leader>vd", cmd_fn("Gitsigns", { "diffthis" }), { desc = "Diff" })
keymap("n", "<leader>vp", cmd_fn("Gitsigns", { "preview_hunk" }), { desc = "Preview Diff" })
keymap("n", "<leader>vc", cmd_fn "DiffviewOpen", { desc = "Git Diff" })

-- Diagnostic
keymap("n", "<leader>x", partial(show_keymap, "<leader>x"), { desc = "+Diagnostic" })
keymap("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
keymap("n", "<leader>xb", vim.diagnostic.setloclist, { desc = "Buffer Diagnostic" })
keymap("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace Diagnostic" })
-- map("n", "<leader>x]", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
-- map("n", "<leader>x[", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

-- Editor
keymap("n", "<leader><CR>", cmd_fn "noh", { desc = "Clear Highlight" })
local function tree_layout() vim.treesitter.show_tree { command = "topleft 50vnew" } end
keymap("n", "<leader>s", tree_layout, { desc = "Toggle TreeSitter Playground" })
keymap("n", "<CR>", "o", { desc = "New Line" })
keymap("n", ",", cmd_fn "vs", { desc = "Split Vertically" })
keymap("ni", "<c-t>", [[<CMD>execute v:count . "ToggleTerm"<CR>]], { desc = "Toggle Terminal" })
keymap("n", "vv", "V", { desc = "Visual Line" })
keymap("n", "vc", "<C-v>", { desc = "Visual Block" })

-- WorkBench
keymap("n", "<leader>w", partial(show_keymap, "<leader>w"), { desc = "+WorkBench" })
keymap("n", "<leader>wi", function()
  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  local name = vim.api.nvim_buf_get_name(0)
  vim.notify(vim.inspect { filetype = ft, name = name })
end, { desc = "Inspect Buffer" })
keymap("n", "<leader>wI", [[<CMD>Inspect<CR>]], { desc = "Inspect Position" })
keymap("n", "<leader>wu", function()
  vim.cmd.PackerSync()
  vim.cmd.PackerCompile()
end, { desc = "Update Extensions" })
keymap("n", "<leader>wt", function()
  if vim.o.background == "dark" then
    vim.opt.background = "light"
    vim.cmd.color(vim.settings.get("vim.ui.preferredLightTheme", "tokyonight-day"))
  else
    vim.opt.background = "dark"
    vim.cmd.color(vim.settings.get("vim.ui.preferredDarkTheme", "tokyonight-night"))
  end
end, { desc = "Switch Theme" })

-- Scroll disabled
keymap("", "<ScrollWheelUp>", "<Nop>")
keymap("", "<ScrollWheelDown>", "<Nop>")
keymap("", "<S-ScrollWheelUp>", "<Nop>")
keymap("", "<S-ScrollWheelDown>", "<Nop>")
