--#region Window
keymap("nv", "<M-h>", "<c-w>10<")
keymap("nv", "<M-l>", "<c-w>10>")
keymap("nv", "<M-j>", "<c-w>4+")
keymap("nv", "<M-k>", "<c-w>4-")
keymap("nv", "<M-=>", "<c-w>=")
keymap("nvt", "<C-h>", cmd_fn("wincmd", { "h" }))
keymap("nvt", "<C-l>", cmd_fn("wincmd", { "l" }))
keymap("nvt", "<C-j>", cmd_fn("wincmd", { "j" }))
keymap("nvt", "<C-k>", cmd_fn("wincmd", { "k" }))
--#endregion

--#region Cursor Movement
keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-l>", "<Right>")
keymap("nv", "H", "^")
keymap("nv", "L", "$")
--#endregion

--#region Package Info
keymap("n", "<leader>lm", cmd_fn "Mason", { desc = "Manage Mason" })
keymap("n", "<leader>lr", cmd_fn "LspRestart", { desc = "Restart LSP" })
keymap("n", "<leader>li", cmd_fn "LspInfo", { desc = "Show Server Info" })
keymap("n", "<leader>ln", cmd_fn "NullLsInfo", { desc = "Show NullLs Info" })
keymap("n", "<leader>lp", cmd_fn "Lazy", { desc = "Manage Plugins" })
--#endregion

--#region VCS
keymap("n", "<leader>vd", cmd_fn("Gitsigns", { "diffthis" }), { desc = "Diff" })
keymap("n", "<leader>vp", cmd_fn("Gitsigns", { "preview_hunk" }), { desc = "Preview Diff" })
--#endregion

--#region Diagnostic
keymap("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
keymap("n", "<leader>xb", vim.diagnostic.setloclist, { desc = "Buffer Diagnostic" })
keymap("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace Diagnostic" })
keymap("n", "[x", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
keymap("n", "]x", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
--#endregion

--#region Editor
keymap("n", "vv", "V", { desc = "Visual Line" })
keymap("n", "vc", "<C-v>", { desc = "Visual Block" })
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("n", "<leader><CR>", cmd_fn "noh", { desc = "Clear Highlight" })
local function tree_layout() vim.treesitter.show_tree { command = "topleft 50vnew" } end
keymap("n", "<leader>ct", tree_layout, { desc = "TreeSitter Playground" })
keymap("n", ",", "vsplit")
keymap("nvi", "<c-t>", [[<CMD>execute v:count . "ToggleTerm"<CR>]])
--#endregion

--#region WorkBench
keymap("n", "<leader>wi", "<CMD>Inspect<CR>", { desc = "Inspect Position" })
keymap("n", "<leader>wu", "<CMD>Lazy sync<CR>", { desc = "Update Extensions" })
keymap("n", "<leader>wt", function()
  local mode = vim.o.background == "dark" and "light" or "dark"
  vim.opt.background = mode
end, { desc = "Switch Theme" })
--#endregion

--#region Scroll disabled
keymap("", "<ScrollWheelUp>", "<Nop>")
keymap("", "<ScrollWheelDown>", "<Nop>")
keymap("", "<S-ScrollWheelUp>", "<Nop>")
keymap("", "<S-ScrollWheelDown>", "<Nop>")
--#endregion
