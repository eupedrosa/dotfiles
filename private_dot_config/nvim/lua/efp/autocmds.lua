
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
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
        "fugitive",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

--
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    group = augroup("textwidth"),
    pattern = {"*.tex", "*.md", "*.txt"},
    callback = function(event)
        vim.bo[event.buf].textwidth = 80
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
