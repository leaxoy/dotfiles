-- parse the lines from result to get a list of the desirable output
-- Example:
-- // Recursive expansion of the eprintln macro
-- // ============================================

-- {
--   $crate::io::_eprint(std::fmt::Arguments::new_v1(&[], &[std::fmt::ArgumentV1::new(&(err),std::fmt::Display::fmt),]));
-- }
local function parse_lines(t)
  local ret = {}

  local name = t.name
  local text = "// Recursive expansion of the " .. name .. " macro"
  table.insert(ret, "// " .. string.rep("=", string.len(text) - 3))
  table.insert(ret, text)
  table.insert(ret, "// " .. string.rep("=", string.len(text) - 3))
  table.insert(ret, "")

  local expansion = t.expansion
  for string in string.gmatch(expansion, "([^\n]+)") do
    table.insert(ret, string)
  end

  return ret
end

local function rust_expand_macro(direction)
  vim.lsp.buf_request(0, "rust-analyzer/expandMacro", vim.lsp.util.make_position_params(), function(_, result)
    local latest_buf_id = nil
    -- echo a message when result is nil (meaning no macro under cursor) and
    -- exit
    if result == nil then
      vim.api.nvim_out_write("No macro under cursor!\n")
      return
    end

    -- check if a buffer with the latest id is already open, if it is then
    -- delete it and continue
    if latest_buf_id ~= nil then
      vim.api.nvim_buf_delete(latest_buf_id, { force = true })
    end

    -- create a new buffer
    latest_buf_id = vim.api.nvim_create_buf(false, true) -- not listed and scratch

    -- split the window to create a new buffer and set it to our window
    vim.cmd(direction or "vsplit")
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), latest_buf_id)

    -- set filetpe to rust for syntax highlighting
    vim.api.nvim_buf_set_option(latest_buf_id, "filetype", "rust")
    -- write the expansion content to the buffer
    vim.api.nvim_buf_set_lines(latest_buf_id, 0, 0, false, parse_lines(result))

    -- make the new buffer smaller
    -- utils.resize(true, "-25")
  end)
end

vim.api.nvim_create_user_command(
  "RustExpandMacro",
  function() rust_expand_macro() end,
  { desc = "Rust Expand Macro" }
)
