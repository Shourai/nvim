# Neovim

Neovim config for version 0.12+, used on Arch Linux, Ubuntu and macOS. Cloned to `~/Documents/github/nvim`
and linked to `~/.config/nvim` by the [dotfiles](https://github.com/Shourai/dotfiles) setup.

Requirements: the `tree-sitter` CLI, a C compiler, `curl` and `tar` (parsers); `npm`/`node` and `python3`
(`:MasonInstallAll`); `fzf`, `ripgrep` and `fd` (fzf-lua); `lazygit` (`<leader>g`). All are installed by the
dotfiles package lists.

Update: `:Lazy sync`, `:MasonUpdate`, `:TSUpdate`, then `:checkhealth`.

Inspired by:\
<https://www.youtube.com/@vhyrro>\
<https://www.youtube.com/@MrJakob>\
<https://www.youtube.com/@theradlectures>\
<https://www.youtube.com/@joseanmartinez>

## Layout

| Path                  | Contains                                                         |
|-----------------------|------------------------------------------------------------------|
| `init.lua`            | loads the files in `lua/config/`                                 |
| `lua/config/`         | settings, filetypes, keymaps, autocommands, LSP list, Python runner, lazy.nvim |
| `lua/plugins/`        | one file per plugin (lazy.nvim spec)                             |
| `lsp/`                | overrides on top of nvim-lspconfig's server configs              |
| `cfg_linters/`        | config for markdownlint and yamllint                             |

## LSPs, formatters and linters

| What        | Where                       | Notes                                                   |
|-------------|-----------------------------|---------------------------------------------------------|
| LSP servers | `lua/config/lsp.lua`        | `lsp.lua` is the list of servers that start (Mason's automatic enable is off); configs come from nvim-lspconfig, `lsp/` overrides them |
| Formatters  | `lua/plugins/conform.lua`   | format on save; Terraform via OpenTofu (`tofu fmt`); unlisted filetypes use the LSP |
| Linters     | `lua/plugins/nvim-lint.lua` | run on read, save and leaving insert mode; Python and Terraform are linted by their LSPs |
| Parsers     | `lua/plugins/treesitter.lua`| installed automatically; needs the `tree-sitter` CLI, a C compiler, `curl` and `tar` |

Install all servers, formatters and linters with `:MasonInstallAll`.

## Keys

`<leader>` is Space.

| Keys                        | What it does                                         |
|-----------------------------|------------------------------------------------------|
| `<leader>ff` / `fb` / `fg` / `ft` | fzf-lua: files / buffers / live grep / all pickers |
| `<leader>g`                 | lazygit                                              |
| `<leader>ms`                | markview split preview                               |
| `<leader>pr`                | run the current Python file in a tmux pane (Python buffers only) |
| `<leader>pp`                | run the current Python file and show the output (Python buffers only) |
| `<leader>ts`                | choose the tmux pane for `<leader>pr` (Python buffers only) |
| `<leader>rc`                | source the current Lua file (useful for `lua/config` files; plugin specs need a restart, `:restart` in 0.12) |
| `Ctrl-h/j/k/l`              | move between splits and tmux panes (tmux.nvim)       |
| `Alt-h/j/k/l`               | resize splits (tmux.nvim)                            |
| `Ctrl-Alt-h/j/k/l`          | swap panes (tmux.nvim)                               |

On macOS AeroSpace takes `Alt-h/j/k/l`, so the Alt resize keys only work on Linux.

## Behaviour worth knowing

- Modified buffers are saved automatically when you leave the buffer or Neovim loses focus, and files are
  formatted on save.
- Completion (blink.cmp) uses the super-tab preset: `Tab` accepts.
- Text objects: `am`/`im` function, `af`/`if` call, `ac`/`ic` class, `aa`/`ia` parameter, `ai`/`ii` conditional,
  `al`/`il` loop, `a=`/`i=` assignment; `ab`/`ib` and `` a` ``/`` i` `` code blocks in Markdown only.
- nvim-surround: `ys` adds, `ds` deletes and `cs` changes surroundings.
- `q` closes help, man and quickfix windows.
