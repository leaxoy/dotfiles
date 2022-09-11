vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

local dap = require("dap")

dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "go",
    name = "Debug File",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug Package",
    request = "launch",
    program = "${fileDirname}",
  },
  {
    type = "go",
    name = "Debug test file", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

local function modify_tags(action)
  return function(opts)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local ts_node = vim.treesitter.get_node_at_position(0, cursor[1] - 1, cursor[2], {})
    if ts_node == nil or ts_node:type() ~= "type_identifier" or ts_node:parent():type() ~= "type_spec" then
      vim.api.nvim_err_writeln("not on go struct")
      return
    end
    local struct_name = vim.treesitter.query.get_node_text(ts_node, 0)
    if struct_name == nil then return end
    if not vim.fn.executable("gomodifytags") then
      vim.api.nvim_err_writeln("gomodifytags not exist in path, please install it, doc at: https://github.com/fatih/gomodifytags")
      return
    end
    local file = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    local cmd = "gomodifytags -file " .. file .. " -struct " .. struct_name
    local arg = opts.fargs and table.concat(opts.fargs, ",") or opts.arg
    if action == "clear" then
      cmd = cmd .. " -" .. action .. "-tags " .. " -w"
    else
      cmd = cmd .. " -" .. action .. "-tags " .. arg .. " -w"
    end
    vim.fn.system(cmd)
    vim.cmd({ cmd = "edit" })
  end
end

local function switch_test_file(bang, cmd)
  local file = vim.fn.expand("%")
  if not file then return end
  local root = ""
  local alt_file = ""
  if #file <= 1 then
    vim.notify("no buffer name", vim.lsp.log_levels.ERROR)
    return
  end
  local s, e = string.find(file, "_test%.go$")
  local s2, e2 = string.find(file, "%.go$")
  if s ~= nil then
    root = vim.fn.split(file, "_test.go")[1]
    alt_file = root .. ".go"
  elseif s2 ~= nil then
    root = vim.fn.split(file, ".go")[1]
    alt_file = root .. "_test.go"
  else
    vim.notify("not a go file", vim.lsp.log_levels.ERROR)
  end
  if not vim.fn.filereadable(alt_file) and not vim.fn.bufexists(alt_file) and not bang then
    vim.notify("couldn't find " .. alt_file, vim.lsp.log_levels.ERROR)
    return
  elseif #cmd <= 1 then
    local ocmd = "e " .. alt_file
    vim.cmd(ocmd)
  else
    local ocmd = cmd .. " " .. alt_file
    vim.cmd(ocmd)
  end
end

local function go_tag_list(a, l, p) return { "json", "yaml", "xml", "db" } end

vim.api.nvim_create_user_command("GoAddTags", modify_tags("add"),
  { nargs = "+", desc = "Add tags to struct", complete = go_tag_list })
vim.api.nvim_create_user_command("GoRemoveTags", modify_tags("remove"),
  { nargs = "+", desc = "Remove tags from struct", complete = go_tag_list })
vim.api.nvim_create_user_command("GoClearTags", modify_tags("clear"), { desc = "Clear all tags from struct" })
vim.api.nvim_create_user_command("GoSwitchTest", function(opts) switch_test_file(opts.bang) end,
  { desc = "Switch to test file" })
