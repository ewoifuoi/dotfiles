
return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    Lazy = false,
  },
  {
     "nvim-treesitter/nvim-treesitter",
    Lazy = false,
    opts = function(_, opts)
      opts.textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["fj"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["fk"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    Lazy = false,
  },
}
