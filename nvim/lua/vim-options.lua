vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.g.maplocalleader= "\\"
vim.opt.number = true
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', {})
