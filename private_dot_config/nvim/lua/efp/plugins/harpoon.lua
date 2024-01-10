
local function harpoon_append()
    require("harpoon"):list():append()
end

local function harpoon_toggle()
    local h = require("harpoon")
    h.ui:toggle_quick_menu(h:list())
end

local function harpoon_select(index)
    require("harpoon"):list():select(index)
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {"<leader>a", harpoon_append },
        {"<leader>z", harpoon_toggle },
        {"<leader>1", function() harpoon_select(1) end },
        {"<leader>2", function() harpoon_select(2) end },
        {"<leader>3", function() harpoon_select(3) end },
        {"<leader>4", function() harpoon_select(4) end },
        {"<leader>5", function() harpoon_select(5) end },
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
    end
}
