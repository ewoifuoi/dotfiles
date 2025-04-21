require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {desc = "Close NvimTree"})


local function find_pyproject()
  local path = vim.fn.expand("%:p:h")
  while path ~= "/" do
    if vim.fn.filereadable(path .. "/pyproject.toml") == 1 then
      return true
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return false
end

map({"n", "i"},"<F5>", function ()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:p")
  local basename = vim.fn.expand("%:t:r")
  local cmd = ""

  vim.cmd("w")

  if filetype == "python" then
    if find_pyproject() then
      cmd = "uv run " .. filename
    else
      cmd = "python " .. filename
    end
  elseif filetype == "cpp" then
    local output = "./" .. basename
    cmd = "g++ --std=c++20 -O2 -o " .. output .." " .. filename .. "&&" .. output
  end
  vim.cmd("split | terminal " .. cmd)
  vim.cmd("startinsert")
end)



