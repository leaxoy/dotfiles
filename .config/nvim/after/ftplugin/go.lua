local function modify_tags(action)
  return function(opts)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local ts_node = vim.treesitter.get_node_at_pos(0, cursor[1] - 1, cursor[2], {})
    if
      ts_node == nil
      or ts_node:type() ~= "type_identifier"
      or ts_node:parent():type() ~= "type_spec"
    then
      vim.api.nvim_err_writeln "not on go struct"
      return
    end
    local struct_name = vim.treesitter.query.get_node_text(ts_node, 0)
    if struct_name == nil then return end
    local file = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")

    local args = { "-file", file, "-struct", struct_name, "-format", "json" }
    if action == "clear" then
      table.insert(args, "-clear-tags")
    else
      table.insert(args, "-" .. action .. "-tags")
      table.insert(args, opts.fargs and table.concat(opts.fargs, ",") or opts.arg or "json")
    end

    require("plenary.job")
      :new({
        command = "gomodifytags",
        args = args,
        on_exit = function(result, code)
          if code ~= 0 then
            vim.notify("gomodifytags failed, error code: " .. code, vim.log.levels.ERROR)
          end
          local modify = vim.json.decode(table.concat(result:result(), ""))
          vim.schedule(function()
            local set_lines = vim.api.nvim_buf_set_lines
            set_lines(0, modify["start"] - 1, modify["end"], false, modify["lines"])
            vim.cmd.write {}
          end)
        end,
      })
      :start()
  end
end

local function switch_test_file(bang, cmd)
  local file = vim.fn.expand "%"
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

local function cmd(n, f, narg, desc, cmp)
  vim.api.nvim_create_user_command(n, f, { nargs = narg, desc = desc, complete = cmp })
end

cmd("GoAddTags", modify_tags "add", "+", "Add struct tags", go_tag_list)
cmd("GoRmRags", modify_tags "remove", "+", "Remove struct tags", go_tag_list)
cmd("GoClearTags", modify_tags "clear", nil, "Clear struct tags", nil)
cmd("GoSwitchTest", function(opts) switch_test_file(opts.bang) end, nil, "Switch test file", nil)

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end,
})
