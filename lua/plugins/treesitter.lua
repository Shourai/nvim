return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
  opts = {
    ensure_installed = {
      "python",
      "bash",
      "go",
      "yaml",
      "json",
      "lua",
      "javascript",
      "markdown",
      "dockerfile",
      "gitignore",
      "html",
      "css",
      "typescript",
    },

    highlight = { -- enable highlighting for all file types
      enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },

    incremental_selection = {
      enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
      disable = { "cpp", "lua" },
      keymaps = { -- mappings for incremental selection (visual mappings)
        init_selection = "gnn", -- maps in normal mode to init the node/scope selection
        node_incremental = "grn", -- increment to the upper named parent
        scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm", -- decrement to the previous node
      },
    },
    textobjects = {
      -- These are provided by
      select = {
        enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
        keymaps = {
          -- You can use the capture groups defined here:
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@statement.inner",
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
