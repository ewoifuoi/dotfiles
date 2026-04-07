local function patch_vim_validate()
  if vim.g.user_validate_compat_patched then
    return
  end

  local validate = vim.validate

  vim.validate = function(first, ...)
    if select("#", ...) == 0 and type(first) == "table" then
      for name, spec in pairs(first) do
        validate(name, spec[1], spec[2], spec[3], spec[4])
      end
      return
    end

    return validate(first, ...)
  end

  vim.g.user_validate_compat_patched = true
end

local function patch_cmp_nvim_lsp()
  local ok, source = pcall(require, "cmp_nvim_lsp.source")
  if not ok or source._user_compat_patched then
    return
  end

  source.is_available = function(self)
    if self.client:is_stopped() then
      return false
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local get_clients = vim.lsp.get_clients ~= nil and vim.lsp.get_clients or vim.lsp.get_active_clients

    if vim.tbl_isempty(get_clients({ bufnr = bufnr, id = self.client.id })) then
      return false
    end

    if not self:_get(self.client.server_capabilities, { "completionProvider" }) then
      return false
    end

    return true
  end

  source.resolve = function(self, completion_item, callback)
    if self.client:is_stopped() then
      return callback()
    end

    if not self:_get(self.client.server_capabilities, { "completionProvider", "resolveProvider" }) then
      return callback()
    end

    self:_request("completionItem/resolve", completion_item, function(_, response)
      callback(response or completion_item)
    end)
  end

  source.execute = function(self, completion_item, callback)
    if self.client:is_stopped() then
      return callback()
    end

    if not completion_item.command then
      return callback()
    end

    self:_request("workspace/executeCommand", completion_item.command, function()
      callback()
    end)
  end

  source._request = function(self, method, params, callback)
    if self.request_ids[method] ~= nil then
      self.client:cancel_request(self.request_ids[method])
      self.request_ids[method] = nil
    end

    local _, request_id
    _, request_id = self.client:request(method, params, function(arg1, arg2, arg3)
      if self.request_ids[method] ~= request_id then
        return
      end

      self.request_ids[method] = nil

      if arg1 and arg1.code == -32801 then
        self:_request(method, params, callback)
        return
      end

      if method == arg2 then
        callback(arg1, arg3)
      else
        callback(arg1, arg2)
      end
    end)

    self.request_ids[method] = request_id
  end

  source._user_compat_patched = true
end

return {
  {
    "hrsh7th/nvim-cmp",
    init = function()
      patch_vim_validate()
    end,
    opts = function(_, opts)
      patch_cmp_nvim_lsp()

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- 保留你的 <C-j> 快捷键
      opts.mapping["<C-j>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" })
    end,
  },
}
