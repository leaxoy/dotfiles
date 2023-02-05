-- Basic Keymaps

local function get_visual_selection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})

  text = text:gsub("\n", "")
  return #text > 0 and text or ""
end

local function open_link()
  if vim_mode_in "vV" then
    local selection = get_visual_selection()
    if selection then
      vim.cmd("!open " .. selection)
      return
    end
  end
  vim.cmd [[!open <cfile>]]
end

map { "gx", open_link, desc = "Open link under cursor", mode = { "n", "v" } }

local function resize(direction)
  local count = vim.api.nvim_get_vvar "count"
  if count == 0 then count = 1 end
  local cmd = "resize"
  local modifier = "+"
  if direction == "h" or direction == "l" then cmd = "vertical resize" end
  if direction == "h" or direction == "j" then modifier = "-" end
  vim.cmd(string.format("%s %s%d", cmd, modifier, count))
end

--#region Tabpage
map { "<M-[>", "<CMD>tabprevious<CR>", desc = "Previous tabpage" }
map { "<M-]>", "<CMD>tabnext<CR>", desc = "Next tabpage" }
--#endregion

--#region Window
map { "<M-h>", function() resize "h" end, desc = "Decrease window width" }
map { "<M-l>", function() resize "l" end, desc = "Increase window width" }
map { "<M-j>", function() resize "j" end, desc = "Increase window height" }
map { "<M-k>", function() resize "k" end, desc = "Decrease window height" }
map { "<M-=>", "<C-w>=", desc = "Equally window high and wide" }
map { "<M-w>", "<C-w>w", desc = "Switch windows" }
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
