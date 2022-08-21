local open_jdt_link = function(uri)
  local client
  for _, c in ipairs(vim.lsp.get_active_clients()) do
    if c.config.init_options
        and c.config.init_options.extendedClientCapabilities
        and c.config.init_options.extendedClientCapabilities.classFileContentsSupport then
      client = c
      break
    end
  end
  assert(client, "Must have a buffer open with a language client connected to eclipse.jdt.ls to load JDT URI")
  local buf = vim.api.nvim_get_current_buf()
  local params = { uri = uri }
  local response = nil
  local cb = function(err, result) response = { err, result } end
  local ok, request_id = client.request("java/classFileContents", params, cb, buf)
  assert(ok, "Request to `java/classFileContents` must succeed to open JDT URI. Client shutdown?")
  local wait_ok, reason = vim.wait(100, function() return response end)
  -- local log_path = require("jdtls.path").join(vim.fn.stdpath("cache"), "lsp.log")
  local log_path = vim.fn.stdpath("cache") .. "/lsp.log"
  local buf_content
  if wait_ok and #response == 2 and response[2] then
    local content = response[2]
    if content == "" then
      buf_content = {
        "Received response from server, but it was empty. Check the log file for errors", log_path
      }
    else
      buf_content = vim.split(response[2], "\n", true)
    end
  else
    local error_msg
    if not wait_ok then
      client.cancel_request(request_id)
      local wait_failure = { [-1] = "timeout"; [-2] = "interrupted"; [-3] = "error" }
      error_msg = wait_failure[reason]
    else
      error_msg = response[1]
    end
    buf_content = {
      "Failed to load content for uri",
      uri,
      "",
      "Error was: ",
    }
    vim.list_extend(buf_content, vim.split(vim.inspect(error_msg), "\n"))
    vim.list_extend(buf_content, { "", "Check the log file for errors", log_path })
  end
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, buf_content)
  vim.api.nvim_buf_set_option(0, "filetype", "java")
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

vim.api.nvim_create_autocmd("Filetype", {
  pattern = {
    "go",
    "html",
    "javascriptreact",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "rust",
    "typescriptreact",
    "typescript",
    "vue",
  },
  command = "setlocal tabstop=2 shiftwidth=2 expandtab",
  desc = "set tabstop and shiftwidth for specific filetypes",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf

    require("lsp").activate(client, buf)
  end,
  desc = "setup lsp functions"
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    local opts = {
      focusable = false,
      header = "",
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "if_many",
      prefix = "",
      scope = "cursor",
    }
    vim.diagnostic.open_float(opts)
  end,
  desc = "automatic open float diagnostic window"
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "jdt://*",
  callback = function() open_jdt_link(vim.fn.expand("<amatch>")) end,
  desc = "open jdk source"
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
    vim.keymap.set("t", "jk", "<C-\\><C-n>", opts)
    vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", opts)
    vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", opts)
    vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", opts)
    vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", opts)
  end
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "Cargo.toml",
  callback = require("crates").setup
})
