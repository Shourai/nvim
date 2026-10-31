-- Git change signs in the sign column; only needed once a file is open
return { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} }
