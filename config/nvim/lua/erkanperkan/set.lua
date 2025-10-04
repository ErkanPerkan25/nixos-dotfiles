vim.g.mapleader=" "

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.wrap = false

-- Keymaps
vim.keymap.set("n","<leader>pv", vim.cmd.Ex)

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.autoindent = true


-- Visual Settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- More
vim.opt.swapfile = false
