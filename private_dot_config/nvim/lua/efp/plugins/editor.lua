
-- netrw is replaced by oil.nvim
local g = vim.g
g.loaded_netrw = true
g.loaded_netrwPlugin = true
g.loaded_netrwSettings = true
g.loaded_netrwFileHandlers = true

return {
    {"nvim-tree/nvim-web-devicons"},
    {"tpope/vim-repeat"},
    {"tpope/vim-surround"},
    {"tpope/vim-fugitive", cmd="G"},
    {'lewis6991/spaceless.nvim'},
    {"windwp/nvim-autopairs", event="InsertEnter", config=true},
    {"numToStr/Comment.nvim", event="VeryLazy", config=true},
    {"dbmrq/vim-bucky",  ft = {"markdown", "tex", "plaintex"}},
    {"stevearc/oil.nvim",
        name = "oil",
        keys = {{"-", function() require("oil").open() end }},
        config=true,
    },
}
