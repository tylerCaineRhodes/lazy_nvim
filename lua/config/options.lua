-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
local opt = vim.opt

opt.smoothscroll = false

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.rltvnmbr = false
vim.g.annotate_marks = false

-- Basic settings
opt.number = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.showcmd = true
opt.mouse = "a"
opt.timeout = false
opt.syntax = "enable"
opt.undodir = "~/.config/nvim/undodir"
opt.undofile = true
opt.wrap = false
opt.autoindent = true
opt.backspace = "indent,eol,start"
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.ruler = true
opt.writebackup = false
opt.list = true
opt.listchars = "tab:»·,trail:·,extends:→,precedes:←,nbsp:␣"
opt.showmatch = true
opt.swapfile = false
opt.backup = false
opt.breakindent = true
opt.smartindent = true
opt.smartcase = true
opt.smarttab = true
opt.incsearch = true
opt.hlsearch = true
opt.hidden = true
opt.updatetime = 250
opt.history = 1024
opt.ignorecase = true
opt.autoread = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 4
opt.showmode = false -- don't show twice when using lualine

vim.cmd("set norelativenumber")
