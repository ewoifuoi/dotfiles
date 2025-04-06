require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {desc = "Close NvimTree"})



map({"n", "i"},"<F5>", function ()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:p")
  local cmd = ""
  --自动保存文件
  vim.cmd("w")

  if filetype == "python" then
    cmd = "python " .. filename
  end
  vim.cmd("split | terminal " .. cmd)
  vim.cmd("startinsert")
end)



