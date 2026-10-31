---@type vim.lsp.Config
return {
  -- Pyright also attaches to Python and gives full type hover; Ruff's hover only
  -- shows lint-rule docs, so let K come from Pyright (as Ruff's editor docs recommend).
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
