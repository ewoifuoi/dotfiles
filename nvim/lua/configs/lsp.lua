local lspconfig = require "lspconfig"
local mr = require "mason-registry" -- 这行目前没什么用，之后会用上

local nvlsp = require "nvchad.configs.lspconfig"

---@type MasonLspconfigSettings
local options = {
  handlers = {
    function(server_name)
      ---@diagnostic disable-next-line: undefined-field
      lspconfig[server_name].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      }
    end,
  },
}

return options
