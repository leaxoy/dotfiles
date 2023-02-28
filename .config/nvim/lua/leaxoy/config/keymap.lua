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
  return function()
    local count = vim.api.nvim_get_vvar "count1"
    local cmd = "resize"
    local modifier = "+"
    if direction == "h" or direction == "l" then cmd = "vertical resize" end
    if direction == "h" or direction == "j" then modifier = "-" end
    vim.cmd(string.format("%s %s%d", cmd, modifier, count))
  end
end

--#region Tabpage
map { "<M-[>", "<CMD>tabprevious<CR>", desc = "Previous tabpage" }
map { "<M-]>", "<CMD>tabnext<CR>", desc = "Next tabpage" }
--#endregion

--#region Window
map { "<M-h>", resize "h", desc = "Decrease window width" }
map { "<M-l>", resize "l", desc = "Increase window width" }
map { "<M-j>", resize "j", desc = "Increase window height" }
map { "<M-k>", resize "k", desc = "Decrease window height" }
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
map { "<leader>xc", cursor_diagnostic, desc = "Cursor" }
map { "<leader>xx", vim.diagnostic.open_float, desc = "Line" }
map { "<leader>xb", vim.diagnostic.setloclist, desc = "Buffer" }
map { "<leader>xw", vim.diagnostic.setqflist, desc = "Workspace" }
map { "[x", vim.diagnostic.goto_prev, desc = "Previous diagnostic" }
map { "]x", vim.diagnostic.goto_next, desc = "Next diagnostic" }
--#endregion

--#region Editor
map { "vv", "V", desc = "Visual line" }
map { "vc", "<C-v>", desc = "Visual block" }
map { "<", "<gv", mode = "v", desc = "Indent left" }
map { ">", ">gv", mode = "v", desc = "Indent right" }
map { "<CR>", "<CMD>nohlsearch<CR>", desc = "Clear highlight" }
map { ",", "<CMD>vsplit<CR>", desc = "Vertical split" }
if has "nvim-0.9" then map { "<leader>ct", vim.treesitter.show_tree, desc = "TreeSitter playground" } end
--#endregion

--#region WorkBench
if has "nvim-0.9" then map { "<leader>wi", "<CMD>Inspect<CR>", desc = "Inspect position" } end
local function toggle_theme() vim.opt.background = vim.o.background == "dark" and "light" or "dark" end
map { "<leader>wt", toggle_theme, desc = "Switch theme" }
--#endregion

--#region Scroll disabled
map { "<ScrollWheelUp>", "<Nop>", mode = "" }
map { "<ScrollWheelDown>", "<Nop>", mode = "" }
map { "<S-ScrollWheelUp>", "<Nop>", mode = "" }
map { "<S-ScrollWheelDown>", "<Nop>", mode = "" }
--#endregion
