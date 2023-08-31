-----------------------------------------------------------
-- Autopairs configuration file
-----------------------------------------------------------
-- https://github.com/windwp/nvim-autopairs

return  {
  { 'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
      },
      config = function()
        -- nvim-cmp specific configuration
        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )
      end

    }
  }, -- this is equalent to setup({}) function
  "windwp/nvim-ts-autotag"
}
