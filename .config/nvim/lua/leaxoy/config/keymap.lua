-- Basic Keymaps

--#region Window
map { "<M-h>", "<C-w>10<", desc = "" }
map { "<M-l>", "<C-w>10>", desc = "" }
map { "<M-j>", "<C-w>4+", desc = "" }
map { "<M-k>", "<C-w>4-", desc = "" }
map { "<M-=>", "<C-w>=", desc = "" }
map { "<C-h>", "<CMD>wincmd h<CR>", mode = { "n", "v", "t" } }
map { "<C-l>", "<CMD>wincmd l<CR>", mode = { "n", "v", "t" } }
map { "<C-j>", "<CMD>wincmd j<CR>", mode = { "n", "v", "t" } }
map { "<C-k>", "<CMD>wincmd k<CR>", mode = { "n", "v", "t" } }
--#endregion

--#region Cursor Movement
map { "<C-h>", "<Left>", mode = "i" }
map { "<C-l>", "<Right>", mode = "i" }
map { "<C-j>", "<Down>", mode = "i" }
map { "<C-k>", "<Up>", mode = "i" }
map { "H", "^", mode = { "n", "v" } }
map { "L", "$", mode = { "n", "v" } }
--#endregion

--#region Diagnostic
local function cursor_diagnostic() vim.diagnostic.open_float { scope = "c" } end
map { "<leader>xc", cursor_diagnostic, desc = "Cursor Diagnostic" }
map { "<leader>xx", vim.diagnostic.open_float, desc = "Line Diagnostic" }
map { "<leader>xb", vim.diagnostic.setloclist, desc = "Buffer Diagnostic" }
map { "<leader>xw", vim.diagnostic.setqflist, desc = "Workspace Diagnostic" }
map { "[x", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" }
map { "]x", vim.diagnostic.goto_next, desc = "Next Diagnostic" }
--#endregion

--#region Editor
map { "vv", "V", desc = "Visual Line" }
map { "vc", "<C-v>", desc = "Visual Block" }
map { "<", "<gv", mode = "v", desc = "Indent Left" }
map { ">", ">gv", mode = "v", desc = "Indent Right" }
map { "<CR>", "<CMD>nohlsearch<CR>", desc = "Clear Highlight" }
map { ",", "<CMD>vsplit<CR>", desc = "Vertical Split" }
if has "nvim-0.9" then
  local function tree_layout() vim.treesitter.show_tree { command = "topleft 50vnew" } end
  map { "<leader>ct", tree_layout, desc = "TreeSitter Playground" }
end
--#endregion

--#region WorkBench
if has "nvim-0.9" then map { "<leader>wi", "<CMD>Inspect<CR>", desc = "Inspect Position" } end
local function toggle_theme()
  local mode = vim.o.background == "dark" and "light" or "dark"
  vim.opt.background = mode
end
map { "<leader>wt", toggle_theme, desc = "Switch Theme" }
--#endregion

--#region Scroll disabled
map { "<ScrollWheelUp>", "<Nop>", mode = "" }
map { "<ScrollWheelDown>", "<Nop>", mode = "" }
map { "<S-ScrollWheelUp>", "<Nop>", mode = "" }
map { "<S-ScrollWheelDown>", "<Nop>", mode = "" }
--#endregion
