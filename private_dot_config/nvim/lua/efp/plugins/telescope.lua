
local find_buffers = function()
    builtin = require("telescope.builtin")
    ivy = require("telescope.themes").get_ivy({layout_config={height=11}}) 
    builtin.buffers(ivy)
end

local find_files = function(try_git)
    builtin = require("telescope.builtin")
    ivy = require("telescope.themes").get_ivy({layout_config={height=11}}) 

    if try_git == true then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 then
            builtin.git_files(ivy)
            return
        end
    end
    
    builtin.find_files(ivy)
end

return {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    dependencies = {"nvim-lua/plenary.nvim"},
    cmd = "Telescope", module = "telescope",
    keys = {
        {"<leader>m", find_buffers },
        {"<leader>N", function() find_files(false) end},
        {"<leader>n", function() find_files(true) end},
    },
    opts = {
        defaults = { 
            path_display = { shorten = {len = 2, exclude = {1, -2, -1}} },
            preview = { hide_on_startup = true},
        }, -- end defaults
    }, -- end opts
}
