-- [[ My Simple Status Line ]]

local function find_git_repo()
    local dir = vim.fn.expand("%:h")
    while dir ~= '.' and dir ~= "/" do
        local git_dir = dir .. "/.git"
        if vim.fn.isdirectory(git_dir) == 1 or vim.fn.filereadable(git_dir) == 1 then
            return git_dir
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end

    -- there can be a .git in the root of the relative path
    if dir == '.' then
        local git_dir = ".git"
        if vim.fn.isdirectory(git_dir) == 1 or vim.fn.filereadable(git_dir) == 1 then
            return git_dir
        end
    end

    return nil
end

local function git_info()
    local git_dir = find_git_repo()
    if git_dir == nil then
        return ""
    end

    git_dir = vim.fn.fnamemodify(git_dir, ":h")
    local branch = vim.fn.systemlist("git -C " .. git_dir .. " symbolic-ref --short HEAD")[1]

    return "[" .. branch .. " ] "
end

local refresh_events = {
    "FileChangedShellPost",
    "BufEnter",
    "BufWritePost",
}

vim.api.nvim_create_autocmd(refresh_events, {
    group = vim.api.nvim_create_augroup("stl_refresh", {clear=true}),
    callback = function()
        vim.schedule(function()
            local stl = git_info() .. "%<%f %m%r%=[%{&fileencoding?&fileencoding:&encoding}] %y %4l:%-3c %3p%%"
            vim.o.statusline = stl
        end)
    end
})

vim.o.statusline = "%<%f %m%r%=[%{&fileencoding?&fileencoding:&encoding}] %y %4l:%-3c %3p%%"
