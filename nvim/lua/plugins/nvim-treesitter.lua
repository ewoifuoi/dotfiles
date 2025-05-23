
return {
  "nvim-treesitter/nvim-treesitter",
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
          ["]m"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
      },
    }
    end,
  {
      
    "nvim-treesitter/nvim-treesitter-context",
    Lazy = false,
  },
}
