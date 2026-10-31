return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false, -- nvim-treesitter (main branch) does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    local ts = require("nvim-treesitter")

    local function start(buf, filetype)
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end

      -- enables syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)
    end

    -- Installing parsers needs the tree-sitter CLI, curl, tar and a C compiler
    local missing = {}
    for _, exe in ipairs({ "tree-sitter", "curl", "tar", "cc" }) do
      if vim.fn.executable(exe) == 0 then
        table.insert(missing, exe)
      end
    end
    -- On macOS /usr/bin/cc is a shim that exists even without the Command Line Tools
    if vim.fn.has("mac") == 1 and vim.fn.executable("cc") == 1 then
      vim.fn.system({ "xcode-select", "-p" })
      if vim.v.shell_error ~= 0 then
        table.insert(missing, "Xcode Command Line Tools (xcode-select --install)")
      end
    end

    if #missing > 0 then
      if not vim.g.treesitter_missing_warned then
        vim.g.treesitter_missing_warned = true
        vim.notify("nvim-treesitter: not installing parsers, missing: " .. table.concat(missing, ", "),
          vim.log.levels.WARN)
      end
    else
      -- Install parsers (async; already installed ones are skipped)
      local task = ts.install({
        "bash", "css", "hcl", "html", "javascript", "json", "lua", "markdown", "markdown_inline",
        "python", "regex", "terraform", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
      })

      -- Once done, start treesitter in buffers opened before their parser was installed
      task:await(function()
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local ft = vim.bo[buf].filetype
            if ft ~= "" and vim.api.nvim_buf_is_loaded(buf) and not vim.treesitter.highlighter.active[buf] then
              start(buf, ft)
            end
          end
        end)
      end)
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
      callback = function(args)
        start(args.buf, args.match)
      end,
    })
  end,
}
