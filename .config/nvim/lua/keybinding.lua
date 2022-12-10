local fn = require "fn"
local cmd, map, popup, term = fn.cmd_fn, fn.map_fn, fn.popup_fn, fn.term_fn

-- Session
map("n", "<leader>sl", cmd "SessionLoad", { desc = "Load Session" })
map("n", "<leader>ss", cmd "SessionSave", { desc = "Save Session" })

-- Window
map("n", "<leader>w", popup "<leader>w", { desc = "+Window" })
map("n", "<leader>wc", cmd("wincmd", { "x" }), { desc = "Close Current Window" })
map("n", "<leader>wo", cmd("wincmd", { "o" }), { desc = "Close Other Window" })
map("n", "<leader>wv", cmd "vsplit", { desc = "Split Vertically" })
map("n", "<leader>ws", cmd "split", { desc = "Split Horizonally" })
map("nv", "<M-h>", "<c-w>10<", { desc = "Decrease Width" })
map("nv", "<M-l>", "<c-w>10>", { desc = "Increase Width" })
map("nv", "<M-j>", "<c-w>4+", { desc = "Increase Height" })
map("nv", "<M-k>", "<c-w>4-", { desc = "Decrease Height" })
map("nv", "<M-=>", "<c-w>=", { desc = "Equally high and wide" })
map("nv", "<C-h>", cmd("wincmd", { "h" }), { desc = "Goto Left Window" })
map("nv", "<C-l>", cmd("wincmd", { "l" }), { desc = "Goto Right Window" })
map("nv", "<C-j>", cmd("wincmd", { "j" }), { desc = "Goto Bottom Window" })
map("nv", "<C-k>", cmd("wincmd", { "k" }), { desc = "Goto Top Window" })

-- LSP or DAP or Linter or Formatter
map("n", "<leader>l", popup "<leader>l", { desc = "+Mason" })
map("n", "<leader>lm", cmd "Mason", { desc = "Manage Mason" })
map("n", "<leader>lr", cmd "LspRestart", { desc = "Restart LSP" })
map("n", "<leader>li", cmd "LspInfo", { desc = "Show Server Info" })
map("n", "<leader>ln", cmd "NullLsInfo", { desc = "Show NullLs Info" })

-- VCS
map("n", "<leader>v", popup "<leader>v", { desc = "+VCS" })
map("n", "<leader>vd", cmd("Gitsigns", { "diffthis" }), { desc = "Diff" })
map("n", "<leader>vp", cmd("Gitsigns", { "preview_hunk" }), { desc = "Preview Diff" })
map("n", "<leader>vc", cmd "DiffviewOpen", { desc = "Git Diff" })
if vim.fn.executable "lazygit" then map("n", "<leader>vv", term "lazygit", { desc = "LazyGit" }) end
if vim.fn.executable "tig" then map("n", "<leader>vt", term "tig", { desc = "Tig" }) end

-- Diagnostic
map("n", "<leader>x", popup "<leader>x", { desc = "+Diagnostic" })
map("n", "<leader>xb", vim.diagnostic.setloclist, { desc = "Buffer Diagnostic" })
map("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace Diagnostic" })
map("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
map("n", "<leader>x]", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>x[", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

-- Edit
map("n", "<leader><CR>", cmd "noh", { desc = "Clear Highlight" })
local function tree_layout() vim.treesitter.show_tree { command = "topleft 50vnew" } end
map("n", "<leader>si", tree_layout, { desc = "Toggle TreeSitter Playground" })

-- Terminal
map("ni", "<c-t>", [[<CMD>execute v:count . "ToggleTerm"<CR>]], { desc = "Toggle Terminal" })

-- Scroll
map("", "<ScrollWheelUp>", "<Nop>", {})
map("", "<ScrollWheelDown>", "<Nop>", {})
map("", "<S-ScrollWheelUp>", "<Nop>", {})
map("", "<S-ScrollWheelDown>", "<Nop>", {})
