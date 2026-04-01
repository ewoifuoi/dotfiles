return {
  {
    "L3MON4D3/LuaSnip",
    config = function(_, opts)
      -- 继承 NvChad 默认的 luasnip 配置
      require("nvchad.configs.luasnip")(opts)
      
      -- 加载你的自定义 snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
    end,
  },
}
