-- [[ Options ]]
-- These are options before any plugin is loaded.

-- :help vim.g
local g = vim.g

g.mapleader = ","
g.maplocalleader = " "
-- disable unused vim plugins
g.zipPlugin         = false
g.loaded_zip        = true
g.loaded_zipPlugin  = true
g.loaded_gzip       = true
g.loaded_tar        = true
g.loaded_tarPlugin  = true
g.load_black        = false
g.loaded_logipat    = true
g.loaded_matchit    = true
g.loaded_rrhelper   = true
g.loaded_getscript  = true
g.loaded_vimball    = true
g.loaded_vimballPlugin  = true
g.loaded_2html_plugin   = true
g.loaded_remote_plugins = true

-- :help vim.o
local o = vim.o

-- file handling
o.fileencofing = "utf-8"
o.writebackup = false
o.swapfile = false
o.undofile = true
o.autowrite = true
o.confirm = true

-- tui
o.termguicolors = true
o.signcolumn = 'yes'
o.number = true
o.relativenumber = true
o.hlsearch = false
o.incsearch = true
o.scrolloff = 4
o.sidescrolloff = 4
o.cursorline = true
o.updatetime = 50
o.laststatus = 3

-- editor
o.expandtab 	= true
o.tabstop       = 4
o.smarttabstop 	= 4
o.shiftwidth 	= 4
o.smartcase 	= true
o.ignorecase 	= true
