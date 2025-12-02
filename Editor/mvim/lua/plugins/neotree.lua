-- Configuring icons
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN]  = '',
      [vim.diagnostic.severity.INFO]  = '',
      [vim.diagnostic.severity.HINT]  = '󰌵',
    },
  },
})

-- Configurating neotree fully
require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "NC",
  enable_git_status = true,
  enable_diagnostics = true,
  clipboard = { sync = "none" },
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
  open_files_using_relative_paths = false,
  sort_case_insensitive = false,
})
