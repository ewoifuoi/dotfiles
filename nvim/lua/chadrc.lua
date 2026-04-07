-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

  transparency = true,
	hl_override = {
		Comment = { fg = "#9ca3af", italic = true }, -- 注释颜色调亮 (浅灰)
		["@comment"] = { fg = "#9ca3af", italic = true },
		LineNr = { fg = "#737aa2" }, -- 普通行号颜色调亮
		CursorLineNr = { fg = "#c0caf5", bold = true }, -- 当前光标所在行号更亮
    LspReferenceText = { bg = "NONE", underline = true },
    LspReferenceRead = { bg = "NONE", underline = true },
    LspReferenceWrite = { bg = "NONE", underline = true },
	},
}

M.ui = {
  statusline = {
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "encoding", "eol", "lsp", "cwd", "cursor" },
    modules = {
      encoding = function()
        if vim.list_contains({ "help" }, vim.bo.filetype) then
          return ""
        end
        local encoding = vim.bo.fileencoding:upper()
        if encoding == "" then
          return ""
        end
        return " %*" .. encoding .. " " -- "%*" is used to clear highlight group (use default highlight)
      end,
      eol = function()
        if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal" then
          return ""
        end
        if vim.list_contains({ "help", "terminal", "NvimTree", "nvdash" }, vim.bo.filetype) then
          return ""
        end
        -- LF, CRLF or CR
        local file_format = vim.bo.fileformat
        local eol
        if file_format == "unix" then
          eol = "LF"
        elseif file_format == "dos" then
          eol = "CRLF"
        elseif file_format == "mac" then
          eol = "CR"
        end
        return " %*" .. eol .. " " -- "%*" is used to clear highlight group (use default highlight)
      end,
    },
  },
}

 M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
