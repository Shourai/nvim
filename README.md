# Neovim

Neovim config based on version 0.11.4+.

Inspired by:
<https://www.youtube.com/@vhyrro>
<https://www.youtube.com/@MrJakob>
<https://www.youtube.com/@theradlectures>
<https://www.youtube.com/@joseanmartinez>

## LSPs, formatters and linters

For the LSPs being used check:

```
lua/config/lsp.lua
```

Since we are not using `nvim-lspconfig` we should manually add the lsp config files
from <https://github.com/neovim/nvim-lspconfig/tree/master/lsp> to the `lsp` folder.

For the formatters check:

```
lua/plugins/conform.lua
```

For the linters check:

```
lua/plugins/nvim-lint.lua
```
