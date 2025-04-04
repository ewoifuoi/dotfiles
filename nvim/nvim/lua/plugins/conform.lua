---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = function ()
      return require "configs.conform"
    end
  },
}
