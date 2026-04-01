return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main", -- Ensure you are tracking the main branch
  init = function()
    -- Disable built-in ftplugin mappings to prevent conflicts with your custom ones
    -- This is recommended by the plugin documentation
    vim.g.no_plugin_maps = true
  end,
  config = function()
    local ts_select = require("nvim-treesitter-textobjects.select")

    require("nvim-treesitter-textobjects").setup({
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "v",
        },
      },
    })

    -- Define Keymaps manually for the 'main' branch
    local mappings = {
      -- Assignments
      ["a="] = "@assignment.outer",
      ["i="] = "@assignment.inner",
      ["l="] = "@assignment.lhs",
      ["r="] = "@assignment.rhs",
      -- Parameters/Arguments
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
      -- Conditionals/Loops
      ["ai"] = "@conditional.outer",
      ["ii"] = "@conditional.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      -- Functions/Calls
      ["af"] = "@call.outer",
      ["if"] = "@call.inner",
      ["am"] = "@function.outer",
      ["im"] = "@function.inner",
      -- Classes
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      -- Blocks/Markdown
      ["ib"] = "@block.inner",
      ["ab"] = "@block.outer",
      ["i`"] = "@block.inner",
      ["a`"] = "@block.outer",
    }

    for key, query in pairs(mappings) do
      vim.keymap.set({ "x", "o" }, key, function()
        ts_select.select_textobject(query, "textobjects")
      end, { desc = "Select " .. query })
    end
  end,
}
