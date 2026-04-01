

---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
  },

  {
    "williamboman/mason.nvim",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      return require "configs.lsp"
    end,
  },
}
