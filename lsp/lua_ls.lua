---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      -- Neovim runs LuaJIT; only the Neovim runtime is added (plugins are not indexed)
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      }
    }
  }
}
