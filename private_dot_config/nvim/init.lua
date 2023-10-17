-------------------------------------------------------------
-- OPTIONS
-------------------------------------------------------------
local g = vim.g
g.mapleader = ","
g.maplocalleader = " "

local o = vim.o
o.fileencofing = "utf-8"
o.autowrite = true
o.clipboard = "unnamedplus"
o.confirm = true

o.writebackup = false
o.swapfile = false
o.undofile = true
o.autowrite = true

-- Visual
o.termguicolors = true
o.signcolumn = 'yes'
o.number = true
o.relativenumber = true
o.hlsearch = false
o.incsearch = true
o.scrolloff = 4
o.sidescrolloff = 4
o.cursorline = true
o.showmode = true
o.updatetime = 50
o.laststatus = 3
o.showmode = false

-- Editor
o.expandtab 	= true
o.tabstop 	    = 4
o.smarttabstop 	= 4
o.shiftwidth 	= 4
o.smartcase 	= true
o.ignorecase 	= true

-- Commands
if vim.fn.executable('rg') == 1 then
    o.grepprg = 'rg --vimgrep --smart-case --hidden --glob !.git'
end

-- disable vim plugins
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
g.loaded_netrw          = true
g.loaded_netrwPlugin    = true
g.loaded_netrwSettings  = true
g.loaded_netrwFileHandlers = true

-------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    {"tpope/vim-repeat"},
    {"tpope/vim-commentary"},
    {"tpope/vim-surround"},
    {"tpope/vim-dispatch"},
    {"tpope/vim-fugitive", cmd = "G"},

    {"kaarmu/typst.vim", ft = "typst"},

    {"David-Kunz/gen.nvim"},

    {"catppuccin/nvim", name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
                transparent_background = true,
                custom_highlights = function(colors)
                    return { ["MiniTrailspace"] = { bg = colors.maroon }}
                end
            })
            vim.cmd.colorscheme "catppuccin"
        end
    },

    {"nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons"},
        config = function()
            require("lualine").setup{
                options = {
                    theme = "catppuccin",
                    section_separators = { left = "", right = ""},
                    component_separators = { left = "|", right = "|"}
                },
            }
        end
    },

    {"nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true },
                indent = { enable = true },
                disable = { "latex" }
            })
        end
    },

    {"nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        version = false,
        cmd = "Telescope",
        module = "telescope",
        keys = {
            {"<leader>m", "<cmd>Telescope buffers theme=ivy<cr>"},
            {"<leader>N", "<cmd>Telescope find_files theme=ivy<cr>"},
            {"<leader>n", function()
                local ivy = require("telescope.themes").get_ivy()
                vim.fn.system('git rev-parse --is-inside-work-tree')
                if vim.v.shell_error == 0 then
                    require"telescope.builtin".git_files(ivy)
                else
                    require"telescope.builtin".find_files(ivy)
                end
            end},
        },
        opts = { pickers = { find_files = {
            find_command = {"rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/build/*" }
        }, }, },
    },

    {"stevearc/oil.nvim",
        event = "VeryLazy",
        keys = {{"-", function() require("oil").open() end }},
        name = "oil",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },

    {"serenevoid/kiwi.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {"<leader>ww", function() require("kiwi").open_wiki_index() end},
            {"<leader>wd", function() require("kiwi").open_diary_index() end},
            {"<leader>wn", function() require("kiwi").open_diary_new() end},
            {"<leader>x", function() require("kiwi").todo.toggle() end},
        },
        config = function()
            require("kiwi").setup({
                {name = "notes", path= vim.fn.expand("$HOME/play/book/notes")}
            })
        end
    },

    {"echasnovski/mini.trailspace",
        version = "*" ,
        event = { "BufReadPost", "BufNewFile" },
        keys = { { "<leader>dt", function() require("mini.trailspace").trim() end } },
        config = function()
            require("mini.trailspace").setup{}
        end
    },

    {"echasnovski/mini.pairs",
        version = "*" ,
        event = "InsertEnter",
        config = function()
            require("mini.pairs").setup{}
        end
    },

    {"neovim/nvim-lspconfig",
        ft = {"rust", "go"},
        config = function()
            local lspconfig = require("lspconfig")
            -- go install golang.org/x/tools/gopls@latest
            lspconfig.gopls.setup{}
            -- see https://rustup.rs/
            lspconfig.rust_analyzer.setup{}

            -- add a border dot lsp and diagnostics floating window
            local _border = "single"
            local h = vim.lsp.handlers
            h["textDocument/hover"] = vim.lsp.with(h.hover, {border=_border})
            h["textDocument/signatureHelp"] = vim.lsp.with(h.signature_help, {border=_border})

            vim.diagnostic.config{float={border=_border}}
        end
    },

    {"hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-nvim-lsp"},
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-l>'] = {i = cmp.mapping.confirm({ select = false })},
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                window = {
                    documentation = {border="single"}
                }
            })
        end
    },
})

-------------------------------------------------------------
-- AUTO COMMANDS
-------------------------------------------------------------
local function augroup(name)
    return vim.api.nvim_create_augroup("custom_" .. name, {clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
            vim.cmd [[normal zz]]
        end
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- typst file type
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    group = augroup("typst_support"),
    pattern = {"*.typ"},
    callback = function(event)
        vim.print("Hello World")
        vim.api.nvim_buf_call(event.buf, function()
            vim.api.nvim_cmd({ cmd = 'setf', args = { 'typst' } }, {})
        end)
    end
})

-- lsp configurations
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_user_keys"),
    callback = function(ev)
        local map = vim.keymap.set
        local opt = {buffer = ev.buffer}
        -- show hover information
        map("n", "K", vim.lsp.buf.hover, opt)
        -- goto familiy
        map("n", "gi", vim.lsp.buf.implementation, opt)
        map("n", "gd", vim.lsp.buf.definition, opt)
        map("n", "gD", vim.lsp.buf.declaration, opt)
        map("n", "gr", vim.lsp.buf.references, opt)

        map('n', '<space>e', vim.diagnostic.open_float, opts)
        map('n', '<space>q', vim.diagnostic.setloclist, opts)
    end
})

-------------------------------------------------------------
-- KEYMAPS
-------------------------------------------------------------
local map = vim.keymap.set
-- Alternate buffer
map("n", "<leader>,", "<c-^>")
-- Better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- Move and center
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
-- Better join
map("n", "J", "mzJ`z" , { desc = "Join line"})

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- QuickLazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- Save file
map("n", "<leader>s", "<cmd>up<cr><esc>", { desc = "Save file" })

