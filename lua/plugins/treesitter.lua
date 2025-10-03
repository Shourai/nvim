return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "python", "lua", "vim", "vimdoc", "query", "javascript", "html", "markdown", "markdown_inline"
    },
    auto_install = true,
    sync_install = false,
    highlight = { enable = true },

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
