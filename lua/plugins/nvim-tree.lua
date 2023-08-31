return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  config = function()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- following options are the default
    -- each of these are documented in `:help nvim-tree.OPTION_NAME`

    require("nvim-tree").setup({
      view = {
        side = "right"
      }
    })
  end
}
