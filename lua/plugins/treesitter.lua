return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "python", "lua", "vim", "vimdoc", "javascript", "html", "markdown", "markdown_inline"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = { "tmux" }
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Enter>", -- set to `false` to disable one of the mappings
        node_incremental = "<Enter>",
        scope_incremental = false,
        node_decremental = "<Backspace>",
      },
    },
  }
}
