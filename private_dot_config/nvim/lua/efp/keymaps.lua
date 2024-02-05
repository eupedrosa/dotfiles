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

-- clipboard copy & paste
-- map("v", "<leader>y", '"*y')
-- map("n", "<leader>yy", '"*yy')
-- map("n", "<leader>p", '"*P')
-- map("v", "<leader>p", '"*P')

-- Text Objects
-- Line
map("o", "il", ":<c-u>normal! $v^<cr>", {silent = true})
map("x", "il", ":<c-u>normal! $v^<cr>", {silent = true})
map("o", "al", ":<c-u>normal! $v0<cr>", {silent = true})
map("x", "al", ":<c-u>normal! $v0<cr>", {silent = true})

