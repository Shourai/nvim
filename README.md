# Neovim

Neovim config for version 0.12+, used on Arch Linux and macOS. Cloned to `~/Documents/github/nvim`
and linked to `~/.config/nvim` by the [dotfiles](https://github.com/Shourai/dotfiles) setup.

Inspired by:\
<https://www.youtube.com/@vhyrro>\
<https://www.youtube.com/@MrJakob>\
<https://www.youtube.com/@theradlectures>\
<https://www.youtube.com/@joseanmartinez>

## Layout

| Path                  | Contains                                                         |
|-----------------------|------------------------------------------------------------------|
| `init.lua`            | loads the files in `lua/config/`                                 |
| `lua/config/`         | settings, keymaps, autocommands, LSP list, Python runner, lazy.nvim |
| `lua/plugins/`        | one file per plugin (lazy.nvim spec)                             |
| `lsp/`                | overrides on top of nvim-lspconfig's server configs              |
| `cfg_linters/`        | config for markdownlint and yamllint                             |

## LSPs, formatters and linters

| What        | Where                       | Notes                                                   |
|-------------|-----------------------------|---------------------------------------------------------|
| LSP servers | `lua/config/lsp.lua`        | configs come from nvim-lspconfig; `lsp/` overrides them |
| Formatters  | `lua/plugins/conform.lua`   | format on save; unlisted filetypes use the LSP          |
| Linters     | `lua/plugins/nvim-lint.lua` | run after save; Python and Terraform are linted by their LSPs |
| Parsers     | `lua/plugins/treesitter.lua`| installed automatically; needs the `tree-sitter` CLI   |

Install all servers, formatters and linters with `:MasonInstallAll`.

## Keys

`<leader>` is Space.

| Keys                        | What it does                                         |
|-----------------------------|------------------------------------------------------|
| `<leader>ff` / `fb` / `fg` / `ft` | fzf-lua: files / buffers / live grep / all pickers |
| `<leader>g`                 | lazygit                                              |
| `<leader>ms`                | markview split preview                               |
| `<leader>pr`                | run the current Python file in a tmux pane           |
| `<leader>pp`                | run the current Python file and show the output      |
| `<leader>ts`                | choose the tmux pane for `<leader>pr`                |
| `<leader>rc`                | source the current Lua file                          |
| `Ctrl-h/j/k/l`              | move between splits and tmux panes (tmux.nvim)       |
| `Alt-h/j/k/l`               | resize splits (tmux.nvim)                            |
