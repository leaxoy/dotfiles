vim.g.theme = "catppuccin"

-- treesitter config --
vim.g.ts_syntaxes = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "go",
  "gomod",
  "gowork",
  "java",
  "javascript",
  "lua",
  "rust",
  "org",
  "python",
  "toml",
  "tsx",
  "typescript",
}

-- lsp server config --
vim.g.lsp_servers = {
  "bashls",
  "clangd",
  "cmake",
  "gopls",
  "jdtls",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "taplo",
  "tsserver",
}

-- copilot config --
-- vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = {
  netrw = false,
  qf = false,
  TelescopePrompt = false,
  TelescopeResults = false,
  NvimTree = false,
  Outline = false,
  DressingInput = false,
}
-- filetype config
vim.g.rust_recommended_style = 0

-- neovide
if vim.fn.exists "neovide" then
  vim.o.guifont = "FiraCode Nerd Font Mono:h20"
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.95
  vim.g.neovide_background_color = "#111111"
    .. string.format("%x", vim.fn.float2nr(vim.g.transparency * 255))
  vim.g.neovide_input_macos_alt_is_meta = true
end
