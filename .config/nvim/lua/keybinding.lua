-- map create new keymap
local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts or vim.empty_dict(), { noremap = true, silent = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

local lazygit = function()
  local lazygit = require("toggleterm.terminal").Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = { border = "double" },
  })
  lazygit:toggle()
end

local cmd_fn = require("fn").cmd_fn
local popup = function(key) return function() require("which-key").show(key) end end

-- Welcome
map("n", "<M-a>", cmd_fn "intro", { desc = "Greeting" })

-- Window
map("n", "<leader>w", popup("<leader>w"), { desc = "+Window" })
map("n", "<leader>wc", cmd_fn("wincmd", { "x" }), { desc = "Close Current Window" })
map("n", "<leader>wo", cmd_fn("wincmd", { "o" }), { desc = "Close Other Window" })
map("n", "<leader>wv", cmd_fn "vsplit", { desc = "Split Vertically" })
map("n", "<leader>ws", cmd_fn "split", { desc = "Split Horizonally" })
map("n", "<M-h>", "<c-w>10<", { desc = "Decrease Width" })
map("n", "<M-l>", "<c-w>10>", { desc = "Increase Width" })
map("n", "<M-j>", "<c-w>10+", { desc = "Increase Height" })
map("n", "<M-k>", "<c-w>10-", { desc = "Decrease Height" })
map("n", "<M-=>", "<c-w>=", { desc = "Equally high and wide" })

-- Movement
map("n", "<c-h>", cmd_fn("wincmd", { "h" }), { desc = "Goto Left Window" })
map("n", "<c-l>", cmd_fn("wincmd", { "l" }), { desc = "Goto Right Window" })
map("n", "<c-j>", cmd_fn("wincmd", { "j" }), { desc = "Goto Bottom Window" })
map("n", "<c-k>", cmd_fn("wincmd", { "k" }), { desc = "Goto Top Window" })

-- Buffer
map("n", "<leader>$", cmd_fn("BufferLineGoToBuffer", { "-1" }), { desc = "Goto Last Buffer" })
map("n", "<leader>1", cmd_fn("BufferLineGoToBuffer", { "1" }), { desc = "Goto Buffer 1" })
map("n", "<leader>2", cmd_fn("BufferLineGoToBuffer", { "2" }), { desc = "Goto Buffer 2" })
map("n", "<leader>3", cmd_fn("BufferLineGoToBuffer", { "3" }), { desc = "Goto Buffer 3" })
map("n", "<leader>4", cmd_fn("BufferLineGoToBuffer", { "4" }), { desc = "Goto Buffer 4" })
map("n", "<leader>5", cmd_fn("BufferLineGoToBuffer", { "5" }), { desc = "Goto Buffer 5" })
map("n", "<leader>6", cmd_fn("BufferLineGoToBuffer", { "6" }), { desc = "Goto Buffer 6" })
map("n", "<leader>7", cmd_fn("BufferLineGoToBuffer", { "7" }), { desc = "Goto Buffer 7" })
map("n", "<leader>8", cmd_fn("BufferLineGoToBuffer", { "8" }), { desc = "Goto Buffer 8" })
map("n", "<leader>9", cmd_fn("BufferLineGoToBuffer", { "9" }), { desc = "Goto Buffer 9" })

-- LSP or DAP or Linter or Formatter
map("n", "<leader>l", popup("<leader>l"), { desc = "+Mason" })
map("n", "<leader>lm", cmd_fn "Mason", { desc = "Manage Mason" })
map("n", "<leader>lr", cmd_fn "LspRestart", { desc = "Restart LSP" })
map("n", "<leader>li", cmd_fn "LspInfo", { desc = "Show Server Info" })

map("n", "gf", cmd_fn("Lspsaga", { "lsp_finder" }), { desc = "Lsp Finder" })
map("n", "gp", cmd_fn("Lspsaga", { "preview_definition" }), { desc = "Lsp Preview Definition" })

-- Debug
map("n", "<leader>d", popup("<leader>d"), { desc = "+Debug" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Run | Countine" })
map("n", "<leader>de", function() require("dapui").eval(nil, {}) end, { desc = "Eval Expression" })
map("n", "<leader>df", function() require("dapui").float_element("stacks", {}) end, { desc = "Show Floating Window" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<leader>dn", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Repl" })
map("n", "<leader>du", require("dapui").toggle, { desc = "Debug Window" })

-- VCS
map("n", "<leader>v", popup("<leader>v"), { desc = "+VCS" })
map("n", "<leader>vd", cmd_fn("Gitsigns", { "diffthis" }), { desc = "Diff" })
map("n", "<leader>vp", cmd_fn("Gitsigns", { "preview_hunk" }), { desc = "Preview Diff" })
map("n", "<leader>vv", lazygit, { desc = "LazyGit" })

-- Diagnostic
map("n", "<leader>x", popup("<leader>x"), { desc = "+Diagnostic" })
map("n", "<leader>xt", cmd_fn "TodoQuickFix", { desc = "Workspace Todos" })
map("n", "<leader>xb", vim.diagnostic.setloclist, { desc = "Buffer Diagnostic" })
map("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace Diagnostic" })
map("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
map("n", "<leader>xl", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>x]", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>xh", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "<leader>x[", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

-- Edit
map("n", "<leader>;", "i<CR><Esc>", { desc = "Break Line" })
map("n", "<leader>p", popup("<leader>p"), { desc = "+Preview" })
map("n", "<leader>pm", cmd_fn "Glow", { desc = "Preview Markdow" })
map("n", "<leader>im", cmd_fn("Telescope", { "goimpl" }), { desc = "Impl Golang Interface" })

-- Finder
map("n", "f", popup("f"), { desc = "+Finder" })
map("n", "fw", cmd_fn("Telescope"), { desc = "Open Telescope Window" })
map("n", "ff", cmd_fn("Telescope", { "find_files" }), { desc = "File Finder" })
map("n", "fl", cmd_fn("Telescope", { "file_browser" }), { desc = "File Browser" })
map("n", "fg", cmd_fn("Telescope", { "live_grep_args" }), { desc = "Live Grep" })
map("n", "fc", cmd_fn("Telescope", { "grep_string" }), { desc = "Grep Cursor String" })
map("n", "fb", cmd_fn("Telescope", { "buffers" }), { desc = "All Buffers" })
map("n", "fn", cmd_fn("Telescope", { "notify" }), { desc = "Notifications" })
map("n", "fd", cmd_fn("Telescope", { "diagnostics" }), { desc = "Diagnostics" })
map("n", "fr", cmd_fn("Telescope", { "lsp_references" }), { desc = "[LSP] References" })
map("n", "fi", cmd_fn("Telescope", { "lsp_implementations" }), { desc = "[LSP] Implementations" })
map("n", "fs", cmd_fn("Telescope", { "lsp_document_symbols" }), { desc = "[LSP] Document Symbols" })
map("n", "fo", cmd_fn("Telescope", { "lsp_dynamic_workspace_symbols" }), { desc = "[LSP] Workspace Symbols" })
map("n", "fe", cmd_fn("Telescope", { "packer" }), { desc = "List Packer Plugins" })
map("n", "ft", cmd_fn("TodoTelescope"), { desc = "Todo List" })

-- Test
map("n", "t", popup("t"), { desc = "+Test" })
map("n", "tf", function() require("neotest").run.run() end, { desc = "Test Current Function" })
map("n", "tr", function() require("neotest").run.run(vim.fn.expand("%s")) end, { desc = "Test Current File" })
map("n", "tt", function() require("neotest").run.run(vim.fn.getcwd()) end, { desc = "Test Project" })
map("n", "ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Test Summary Panel" })
map("n", "to", function() require("neotest").output.open({ enter = true }) end, { desc = "Open Test Output Panel" })
map("n", "tj", function() require("neotest").jump.next({ status = "failed" }) end, { desc = "Next Failed Test" })
map("n", "tk", function() require("neotest").jump.prev({ status = "failed" }) end, { desc = "Prev Failed Test" })

map({ "n", "i" }, "<c-t>", cmd_fn "ToggleTerm", { desc = "Toggle Terminal" })
map({ "n", "i" }, "<c-s>", cmd_fn "w", { desc = "Save Current Buffer" })
map({ "n", "i" }, "<c-x>", function() require("bufdelete").bufdelete(0) end, { desc = "Close Current Buffer" })

map("i", "jk", "<Esc>", { desc = "Escape Insert Mode" })
map("i", "<c-u>", "<c-o>u", { desc = "Undo" })
map("i", "<c-y>", "<c-o>yy", { desc = "Copy Line" })
map("i", "<c-p>", "<c-o>p", { desc = "Paste" })

map("", "<ScrollWheelUp>", "<Nop>", {})
map("", "<ScrollWheelDown>", "<Nop>", {})
map("", "<S-ScrollWheelUp>", "<Nop>", {})
map("", "<S-ScrollWheelDown>", "<Nop>", {})
