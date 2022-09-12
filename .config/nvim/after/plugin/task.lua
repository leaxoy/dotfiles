local status, overseer = pcall(require, "overseer")
if not status then
  return
end

overseer.setup {
  strategy = "terminal",
  templates = {},
  auto_detect_success_color = true,
  dap = true,
  actions = {},
  task_list = {
    default_detail = 1,
    max_width = { 100, 0.2 },
    min_width = { 30, 0.1 },
    direction = "right",
    bindings = {
      ["<M-l>"] = "IncreaseDetail",
      ["<M-h>"] = "DecreaseDetail",
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    }
  },
  task_launcher = {},
  task_editor = {},
  task_win = {},
  preload_components = {},
  default_template_prompt = "always"
}