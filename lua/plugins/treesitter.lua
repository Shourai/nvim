-- Treesitter parsers and highlighting (main branch, Neovim 0.12+). Parsers are installed
-- here; highlighting is started per buffer by the FileType autocmd at the bottom.
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false, -- nvim-treesitter (main branch) does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    local ts = require("nvim-treesitter")

    -- Parsers to keep installed
    local parsers = {
      "bash", "css", "hcl", "html", "javascript", "json", "lua", "markdown", "markdown_inline",
      "python", "regex", "terraform", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
    }

    -- Start treesitter in a buffer if a parser for its filetype is installed
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

    -- Build tools needed to compile parsers; only checked when a parser is missing
    local function missing_build_tools()
      local missing = vim.tbl_filter(function(exe)
        return vim.fn.executable(exe) == 0
      end, { "tree-sitter", "curl", "tar", "cc" })
      -- On macOS /usr/bin/cc is a shim that exists even without the Command Line Tools
      if vim.fn.has("mac") == 1 and #missing == 0 and vim.system({ "xcode-select", "-p" }):wait().code ~= 0 then
        table.insert(missing, "Xcode Command Line Tools (xcode-select --install)")
      end
      return missing
    end

    -- Normal startup: every parser is installed, so no processes and no install task
    local installed = ts.get_installed("parsers")
    local to_install = vim.tbl_filter(function(parser)
      return not vim.list_contains(installed, parser)
    end, parsers)

    if #to_install > 0 then
      local missing = missing_build_tools()
      if #missing > 0 then
        -- Warn once per session (config runs again on :Lazy reload)
        if not vim.g.treesitter_missing_warned then
          vim.g.treesitter_missing_warned = true
          vim.notify("nvim-treesitter: not installing parsers, missing: " .. table.concat(missing, ", "),
            vim.log.levels.WARN)
        end
      else
        -- Async install; then start treesitter in buffers opened before their parser existed
        ts.install(to_install):await(function()
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
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
      callback = function(args)
        start(args.buf, args.match)
      end,
    })
  end,
}
