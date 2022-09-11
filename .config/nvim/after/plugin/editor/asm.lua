local status, asm = pcall(require, "compiler-explorer")
if not status then return end

asm.setup {
  open_qflist = true,
  autocmd = {
    enable = true,
    hl = "Search",
  },
  prompt = {
    lang = "Select language",
    compiler = "Select compiler",
    compiler_opts = "Select compiler options",
    formatter = "Select formatter",
    formatter_style = "Select formatter style",
    lib = "Select library",
    lib_version = "Select library version",
  },
}
