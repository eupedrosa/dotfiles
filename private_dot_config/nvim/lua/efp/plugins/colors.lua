return {
    "catppuccin/nvim", name ="catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato",
            transparent_background = true,
            custom_highlights = function(colors)
                return { ["errMsg"] = { bg = colors.maroon }}
            end
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
