require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {desc = "Close NvimTree"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map({"n", "i", "v"}, "<C-f>", {desc = "search search in current buffer"})

