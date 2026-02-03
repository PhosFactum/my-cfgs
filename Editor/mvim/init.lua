-- Basic modules
require('core.plugins')
require('core.mappings')

-- "Makdevim" info statusbar (under)
local appname = "makdevim (mvim)"
vim.o.statusline = " " .. appname .. " %=%f %y %m %r %=Ln %l, Col %c"

-- Vim-standart configurations
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
