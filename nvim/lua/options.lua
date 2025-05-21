require "nvchad.options"

-- add yours here!

local opt = vim.opt
opt.cursorlineopt ='both' -- to enable cursorline!
opt.relativenumber = true

opt.list = true
opt.breakindent = true

vim.g.clipboard = {
    name = 'xclip',
    copy = {
        ['+'] =  'xclip -selection clipboard',
        ['*'] =  'xclip -selection primary',
    },
    paste = {
        ['+'] = 'xclip -selection clipboard -o',
        ['*'] = 'xclip -selection primary -o',
    },
    cache_enabled = true,
}
