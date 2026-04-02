local M = {}

-- 通用的向上查找项目标志文件（如 pyproject.toml, CMakeLists.txt）的函数
local function find_project_marker(marker)
  local path = vim.fn.expand("%:p:h")
  while path ~= "/" do
    if vim.fn.filereadable(path .. "/" .. marker) == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return nil
end

function M.run_code()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:p")
  local basename = vim.fn.expand("%:t:r")
  local cmd = ""

  vim.cmd("w") -- 运行前先保存

  if filetype == "python" then
    if find_project_marker("pyproject.toml") then
      cmd = "uv run " .. filename
    else
      cmd = "python " .. filename
    end

  elseif filetype == "cpp" or filetype == "c" then
    local cmake_path = find_project_marker("CMakeLists.txt")
    if cmake_path then
      -- mkdir -p build 会在没有 build 文件夹时自动创建
      cmd = 'cd "' .. cmake_path .. '" && mkdir -p build && cd build && cmake .. && make && EXE=$(find . -maxdepth 1 -type f -executable | grep -v "CMakeFiles" | head -n 1) && if [ -n "$EXE" ]; then echo -e "\n\n--- Running $EXE ---\n" && $EXE; else echo "No executable found"; fi'
    else
      local output = "./" .. basename
      local compiler = filetype == "cpp" and "g++" or "gcc"
      local std = filetype == "cpp" and "--std=c++20" or ""
      cmd = compiler .. " " .. std .. " -O2 -g -o " .. output .." " .. filename .. " && " .. output
    end

  elseif filetype == "rust" then
    local output = "./" .. basename
    cmd = "rustc " .. filename .." -o " .. output .. " && " .. output
  end

  -- 执行命令
  if cmd ~= "" then
    cmd = cmd .. "\nexit"
    require("nvchad.term").runner({
      pos = "sp",
      cmd = cmd,
      id = "code_runner",
      clear_cmd = true
    })
  else
    vim.notify("No run command defined for filetype: " .. filetype, vim.log.levels.WARN)
  end
end

return M
