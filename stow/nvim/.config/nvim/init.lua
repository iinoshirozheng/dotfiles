vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.clipboard = "unnamedplus"
-- 強制設定背景為深色模式
vim.o.background = 'dark'
require("config.lazy")
