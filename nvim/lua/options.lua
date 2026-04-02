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

-- 当 NvimTree 是仅存的最后一个窗口时，自动关闭 Neovim
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
      if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
        vim.cmd("quit")
      end
    end
})
