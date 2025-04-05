require "nvchad.options"

-- add yours here!

local opt = vim.opt
opt.cursorlineopt ='both' -- to enable cursorline!
opt.relativenumber = true

opt.list = true
opt.breakindent = true

vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
        ['+'] =  'win32yank.exe -i --crlf',
        ['*'] =  'win32yank.exe -i --crlf',
    },
    paste = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = true,
}
