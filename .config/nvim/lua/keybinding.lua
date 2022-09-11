local map = require("fn").map_fn
local cmd = require("fn").cmd_fn
local popup = function(key) return function() require("which-key").show(key) end end

local termprog = function(program)
  local prog = require("toggleterm.terminal").Terminal:new({
    cmd = program,
    hidden = true,
    direction = "float",
    float_opts = { border = "double" },
  })
  prog:toggle()
end

-- Welcome
map("n", "<M-a>", cmd "intro", { desc = "Greeting" })

-- Window
map("n", "<leader>w", popup("<leader>w"), { desc = "+Window" })
map("n", "<leader>wc", cmd("wincmd", { "x" }), { desc = "Close Current Window" })
map("n", "<leader>wo", cmd("wincmd", { "o" }), { desc = "Close Other Window" })
map("n", "<leader>wv", cmd "vsplit", { desc = "Split Vertically" })
map("n", "<leader>ws", cmd "split", { desc = "Split Horizonally" })
map("n", "<M-h>", "<c-w>10<", { desc = "Decrease Width" })
map("n", "<M-l>", "<c-w>10>", { desc = "Increase Width" })
map("n", "<M-j>", "<c-w>10+", { desc = "Increase Height" })
map("n", "<M-k>", "<c-w>10-", { desc = "Decrease Height" })
map("n", "<M-=>", "<c-w>=", { desc = "Equally high and wide" })
map("n", "<C-=>", "<c-w>=", { desc = "Equally high and wide" })
map("n", "<C-h>", cmd("wincmd", { "h" }), { desc = "Goto Left Window" })
map("n", "<C-l>", cmd("wincmd", { "l" }), { desc = "Goto Right Window" })
map("n", "<C-j>", cmd("wincmd", { "j" }), { desc = "Goto Bottom Window" })
map("n", "<C-k>", cmd("wincmd", { "k" }), { desc = "Goto Top Window" })

-- Buffer
local bl_status, bl = pcall(require, "bufferline")
if bl_status then
  map("n", "<C-b>", function() bl.go_to(vim.api.nvim_get_vvar("count") or -1) end, { desc = "Goto Buffer" })
  map("n", "<leader>bp", bl.toggle_pin, { desc = "Pin Buffer" })
end

map("n", "<leader>tp", function() termprog("ipython") end, { desc = "IPython" })
map("n", "<leader>tt", function() termprog("tig") end, { desc = "Tig" })
map("n", "<leader>f", cmd "NeoTreeShowToggle", { desc = "File Explorer" })

-- LSP or DAP or Linter or Formatter
map("n", "<leader>l", popup("<leader>l"), { desc = "+Mason" })
map("n", "<leader>lm", cmd "Mason", { desc = "Manage Mason" })
map("n", "<leader>lr", cmd "LspRestart", { desc = "Restart LSP" })
map("n", "<leader>li", cmd "LspInfo", { desc = "Show Server Info" })

map("n", "<leader>v", popup("<leader>v"), { desc = "+VCS" })
map("n", "<leader>vd", cmd("Gitsigns", { "diffthis" }), { desc = "Diff" })
map("n", "<leader>vp", cmd("Gitsigns", { "preview_hunk" }), { desc = "Preview Diff" })
map("n", "<leader>vv", function() termprog("lazygit") end, { desc = "LazyGit" })
map("n", "<leader>vc", [[<CMD>DiffviewOpen<CR>]], { desc = "Git Diff" })

local lspsaga_status, _ = pcall(require, "lspsaga")
if lspsaga_status then
  map("n", "gf", cmd("Lspsaga", { "lsp_finder" }), { desc = "Lsp Finder" })
  map("n", "gp", cmd("Lspsaga", { "peek_definition" }), { desc = "Lsp Peek Definition" })
end

-- Diagnostic
map("n", "<leader>x", popup("<leader>x"), { desc = "+Diagnostic" })
map("n", "<leader>xb", vim.diagnostic.setloclist, { desc = "Buffer Diagnostic" })
map("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace Diagnostic" })
map("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
map("n", "<leader>x]", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>x[", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "<leader>e]", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next Error" })
map("n", "<leader>e[", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev Error" })

-- Edit
map("n", ";", "i<CR><Esc>", { desc = "Break Line" })
map("n", "<leader><CR>", "o<Esc>", { desc = "New Line" })
map("n", "<leader>p", popup("<leader>p"), { desc = "+Preview" })
map("n", "<leader>pm", cmd "Glow", { desc = "Preview Markdow" })
map("n", "<leader>im", cmd("Telescope", { "goimpl" }), { desc = "Impl Golang Interface" })

local telescope_status, _ = pcall(require, "telescope")
if telescope_status then
  map("n", "f", popup("f"), { desc = "+Finder" })
  map("n", "fw", cmd("Telescope"), { desc = "Open Telescope Window" })
  map("n", "ff", cmd("Telescope", { "find_files" }), { desc = "File Finder" })
  map("n", "fl", cmd("Telescope", { "file_browser", "grouped=true" }), { desc = "File Browser" })
  map("n", "fg", cmd("Telescope", { "live_grep_args" }), { desc = "Live Grep" })
  map("n", "fc", cmd("Telescope", { "grep_string" }), { desc = "Grep Cursor String" })
  map("n", "fb", cmd("Telescope", { "buffers" }), { desc = "All Buffers" })
  map("n", "fn", cmd("Telescope", { "notify" }), { desc = "Notifications" })
  map("n", "fd", cmd("Telescope", { "diagnostics" }), { desc = "Diagnostics" })
  map("n", "fr", cmd("Telescope", { "lsp_references" }), { desc = "[LSP] References" })
  map("n", "fi", cmd("Telescope", { "lsp_implementations" }), { desc = "[LSP] Implementations" })
  map("n", "fs", cmd("Telescope", { "lsp_document_symbols" }), { desc = "[LSP] Document Symbols" })
  map("n", "fO", cmd("Telescope", { "lsp_dynamic_workspace_symbols" }), { desc = "[LSP] Workspace Symbols" })
  map("n", "fe", cmd("Telescope", { "packer" }), { desc = "List Packer Plugins" })
  map("n", "ft", cmd("TodoTelescope"), { desc = "Todo List" })
end

local neotest_status, neotest = pcall(require, "neotest")
if neotest_status then
  map("n", "t", popup("t"), { desc = "+Test" })
  map("n", "tf", function() neotest.run.run() end, { desc = "Test Current Function" })
  map("n", "tr", function() neotest.run.run(vim.fn.expand("%s")) end, { desc = "Test Current File" })
  map("n", "tt", function() neotest.run.run(vim.fn.getcwd()) end, { desc = "Test Project" })
  map("n", "td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug Test" })
  map("n", "ts", function() neotest.summary.toggle() end, { desc = "Toggle Test Summary Panel" })
  map("n", "to", function() neotest.output.open({ enter = true }) end, { desc = "Open Test Output Panel" })
  map("n", "tj", function() neotest.jump.next({ status = "failed" }) end, { desc = "Next Failed Test" })
  map("n", "tk", function() neotest.jump.prev({ status = "failed" }) end, { desc = "Prev Failed Test" })
end


local dap_status, dap = pcall(require, "dap")
if dap_status then
  -- Debug
  map("n", "<leader>d", popup("<leader>d"), { desc = "+Debug" })

  local pb_status, pb = pcall(require, "persistent-breakpoints.api")
  map("n", "<leader>db", function()
    if pb_status then pb.toggle_breakpoint() else dap.toggle_breakpoint() end
  end, { desc = "Toggle Breakpoint" })
  map("n", "<leader>dc", function() dap.continue() end, { desc = "Run | Countine" })
  map("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
  map("n", "<leader>dn", function() dap.step_over() end, { desc = "Step Over" })
  map("n", "<leader>do", function() dap.step_out() end, { desc = "Step Out" })
  map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Repl" })
  local ui_status, ui = pcall(require, "dapui")
  if ui_status then
    map("n", "<leader>de", function() ui.eval(nil, {}) end, { desc = "Eval Expression" })
    map("n", "<leader>df", function() ui.float_element("stacks", {}) end, { desc = "Show Floating Window" })
    map("n", "<leader>du", ui.toggle, { desc = "Debug Window" })
  end
end

map({ "n", "i" }, "<c-t>", [[<CMD>execute v:count . "ToggleTerm"<CR>]], { desc = "Toggle Terminal" })
map({ "n", "i" }, "<c-s>", [[<CMD>w<CR>]], { desc = "Save Current Buffer" })
map({ "n", "i" }, "<c-x>", function() require("bufdelete").bufdelete(0) end, { desc = "Close Current Buffer" })

map("i", "jk", "<Esc>", { desc = "Escape Insert Mode" })
map("i", "<c-u>", "<c-o>u", { desc = "Undo" })
map("i", "<c-y>", "<c-o>yy", { desc = "Copy Line" })
map("i", "<c-p>", "<c-o>p", { desc = "Paste" })

map("", "<ScrollWheelUp>", "<Nop>", {})
map("", "<ScrollWheelDown>", "<Nop>", {})
map("", "<S-ScrollWheelUp>", "<Nop>", {})
map("", "<S-ScrollWheelDown>", "<Nop>", {})
