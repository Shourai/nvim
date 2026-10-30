return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main", -- Ensure you are tracking the main branch
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
    }

    -- Code blocks, Markdown only
    local markdown_mappings = {
      ["ib"] = "@block.inner",
      ["ab"] = "@block.outer",
      ["i`"] = "@block.inner",
      ["a`"] = "@block.outer",
    }

    local function map(key, query, buf)
      vim.keymap.set({ "x", "o" }, key, function()
        ts_select.select_textobject(query, "textobjects")
      end, { buffer = buf, desc = "Select " .. query })
    end

    for key, query in pairs(mappings) do
      map(key, query)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("MarkdownTextobjects", { clear = true }),
      pattern = "markdown",
      callback = function(args)
        for key, query in pairs(markdown_mappings) do
          map(key, query, args.buf)
        end
      end,
    })
  end,
}
