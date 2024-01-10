-- [[ Plugin Management with Lazy ]]

-- automatically install lazy.vim, if needed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.print("bootstrapping lazy.nvim, please wait...")
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("efp.plugins", {
    install = {colorscheme = { "catppuccin" }},
    ui = {border = "single"},
    change_detection = {notify=false},
})
