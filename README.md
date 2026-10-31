# Neovim

Neovim config for version 0.12+, used on Arch Linux, Ubuntu and macOS. Cloned to `~/Documents/github/nvim`
and linked to `~/.config/nvim` by the [dotfiles](https://github.com/Shourai/dotfiles) setup.

Requirements: the `tree-sitter` CLI, a C compiler, `curl` and `tar` (parsers); `npm`/`node` and `python3`
(`:MasonInstallAll`); `fzf`, `ripgrep` and `fd` (fzf-lua); `lazygit` (`<leader>g`);
`tofu` (OpenTofu, Terraform formatting). All are installed by the dotfiles package lists.

Update: `:Lazy sync`, `:MasonUpdate`, `:TSUpdate`, then `:checkhealth`.
Plugin versions aren't pinned (`lazy-lock.json` is gitignored), so a bad update can't be rolled
back from this repo; `:Lazy restore` only helps while the local lock file still has the old versions.

Inspired by:\
<https://www.youtube.com/@vhyrro>\
<https://www.youtube.com/@MrJakob>\
<https://www.youtube.com/@theradlectures>\
<https://www.youtube.com/@joseanmartinez>

## Install

Without the dotfiles setup, clone the repo straight to the config directory:

```sh
git clone git@github.com:Shourai/nvim.git ~/.config/nvim
nvim               # first start bootstraps lazy.nvim, installs plugins and parsers
:MasonInstallAll   # LSP servers, formatters and linters
```

## Layout

| Path                  | Contains                                                         |
|-----------------------|------------------------------------------------------------------|
| `init.lua`            | loads the files in `lua/config/`                                 |
| `lua/config/`         | settings, filetypes, keymaps, autocommands, LSP list, Python runner, lazy.nvim |
| `lua/plugins/`        | one file per plugin (lazy.nvim spec)                             |
| `after/ftplugin/`     | per-filetype setup (Python runner keys)                          |
| `lsp/`                | overrides on top of nvim-lspconfig's server configs              |
| `cfg_linters/`        | config for markdownlint and yamllint                             |

## LSPs, formatters and linters

| What        | Where                       | Notes                                                   |
|-------------|-----------------------------|---------------------------------------------------------|
| LSP servers | `lua/config/lsp.lua`        | `lsp.lua` is the list of servers that start; configs come from nvim-lspconfig, `lsp/` overrides them |
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

LSP keys are Neovim's defaults (`:h lsp-defaults`), no `on_attach` needed:

| Keys                     | What it does                                         |
|--------------------------|------------------------------------------------------|
| `K`                      | hover                                                |
| `grn` / `gra` / `grr`    | rename / code action / references                    |
| `gri` / `grt` / `gO`     | implementation / type definition / document symbols  |
| `Ctrl-s` (insert)        | signature help                                       |
| `[d` / `]d`              | previous / next diagnostic                           |

## Behaviour worth knowing

- Modified buffers are saved automatically when you leave the buffer or Neovim loses focus, and files are
  formatted on save.
- `autowriteall` is on: `:q`, `:e` and switching buffers write modified files without asking.
- Completion (blink.cmp) uses the super-tab preset: `Tab` accepts.
- Text objects: `am`/`im` function, `af`/`if` call, `ac`/`ic` class, `aa`/`ia` parameter, `ai`/`ii` conditional,
  `al`/`il` loop, `a=`/`i=` assignment; `ab`/`ib` and `` a` ``/`` i` `` code blocks in Markdown only.
- nvim-surround: `ys` adds, `ds` deletes and `cs` changes surroundings.
- `q` closes help, man and quickfix windows.
