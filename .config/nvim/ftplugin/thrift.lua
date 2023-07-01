vim.api.nvim_buf_create_user_command(
  0,
  "Format",
  "silent !thrift-fmt -w %",
  { desc = "Format buffer" }
)
