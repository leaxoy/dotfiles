return {
  "echasnovski/mini.nvim",
  event = "BufReadPost",
  config = function()
    require("mini.ai").setup {}
    require("mini.comment").setup {}
    require("mini.map").setup {}
    require("mini.move").setup {
      mappings = { line_left = "", line_right = "", line_down = "", line_up = "" },
    }
    require("mini.pairs").setup {}
    require("mini.surround").setup {}
  end,
}
