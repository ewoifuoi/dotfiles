require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {desc = "Close NvimTree"})
map({"n", "i"}, "<C-a>", "<ESC>gg0vG")


-- 运行代码的快捷键 (逻辑被抽离到了 lua/configs/runner.lua 中)
map({"n", "i"}, "<F5>", function()
  require("configs.runner").run_code()
end, { desc = "Run Code" })



