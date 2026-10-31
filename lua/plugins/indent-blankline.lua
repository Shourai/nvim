-- Indent guides; only needed once a file is open
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
}
