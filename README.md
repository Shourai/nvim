# Neovim

Neovim 0.12+ config for Arch Linux, Ubuntu and macOS. The [dotfiles](https://github.com/Shourai/dotfiles)
setup clones it to `~/Documents/github/nvim`, links it to `~/.config/nvim` and installs everything
below. Without the dotfiles:

```sh
git clone git@github.com:Shourai/nvim.git ~/.config/nvim
nvim               # first start installs lazy.nvim, the plugins and the parsers
:MasonInstallAll   # LSP servers, formatters and linters
```

Needs: `tree-sitter` CLI, a C compiler, `curl`, `tar` (parsers); `npm`/`node`, `python3`, `unzip`
(Mason); `fzf`, `ripgrep`, `fd` (fzf-lua); `lazygit` (`<leader>g`); `tofu` (Terraform formatting;
only on the dev VM, other machines skip it).

**Update**: `:Lazy sync`, `:MasonUpdate`, `:TSUpdate`, then `:checkhealth`. Plugin versions aren't
pinned (`lazy-lock.json` is gitignored): `:Lazy restore` can only go back to what the local lock
file still holds.

## Layout

| Path                  | Contains                                                         |
|-----------------------|------------------------------------------------------------------|
| `init.lua`            | loads the files in `lua/config/`                                 |
| `lua/config/`         | settings, filetypes, keymaps, autocommands, LSP list, Python runner, lazy.nvim |
| `lua/plugins/`        | one file per plugin (lazy.nvim spec)                             |
| `after/ftplugin/`     | per-filetype setup (Python runner keys)                          |
| `lsp/`                | overrides on top of nvim-lspconfig's configs (Ruff's hover is off; Pyright's is used) |
| `cfg_linters/`        | markdownlint and yamllint config                                 |

## LSPs, formatters and linters

| What        | Where                        | Notes                                                   |
|-------------|------------------------------|---------------------------------------------------------|
| LSP servers | `lua/config/lsp.lua`         | the servers to start; configs from nvim-lspconfig, overridden by `lsp/` |
| Formatters  | `lua/plugins/conform.lua`    | on `:w`; unlisted filetypes use the LSP                 |
| Linters     | `lua/plugins/nvim-lint.lua`  | on read, save and leaving insert mode; Python and Terraform via their LSPs |
| Parsers     | `lua/plugins/treesitter.lua` | installed automatically                                 |
| Mason tools | `lua/plugins/mason.lua`      | the list `:MasonInstallAll` installs; keep it in sync with the three above |

## Keys

`<leader>` is Space.

| Keys                        | What it does                                         |
|-----------------------------|------------------------------------------------------|
| `<leader>ff` / `fb` / `fg` / `ft` | fzf-lua: files / buffers / live grep / all pickers |
| `<leader>g`                 | lazygit                                              |
| `<leader>ms`                | markview split preview                               |
| `<leader>pr`                | Python: run the file in a tmux pane                  |
| `<leader>pp`                | Python: run the file, show the output when it exits  |
| `<leader>ts`                | Python: choose the tmux pane for `<leader>pr`        |
| `<leader>rc`                | source the current Lua file (plugin specs need `:restart`) |
| `Ctrl-h/j/k/l`              | move between splits and tmux panes (tmux.nvim)       |
| `Alt-h/j/k/l`               | resize splits (tmux.nvim); not on macOS, AeroSpace takes them |
| `Ctrl-Alt-h/j/k/l`          | swap panes (tmux.nvim)                               |

LSP keys are Neovim's defaults (`:h lsp-defaults`):

| Keys                     | What it does                                         |
|--------------------------|------------------------------------------------------|
| `K`                      | hover                                                |
| `grn` / `gra` / `grr`    | rename / code action / references                    |
| `gri` / `grt` / `gO`     | implementation / type definition / document symbols  |
| `Ctrl-s` (insert)        | signature help                                       |
| `[d` / `]d`              | previous / next diagnostic                           |

## Behaviour worth knowing

- **Edits are written without asking**: modified buffers are saved when you leave them or Neovim
  loses focus, and `autowriteall` makes `:q`, `:e` and buffer switches write too. Formatting runs
  on writes you trigger (`:w`, and `:q`/`:e` through `autowriteall`), not on the leave/focus
  autosaves.
- Completion (blink.cmp): `Tab` accepts (super-tab preset).
- Text objects: `am`/`im` function, `af`/`if` call, `ac`/`ic` class, `aa`/`ia` parameter,
  `ai`/`ii` conditional, `al`/`il` loop, `a=`/`i=` assignment; in Markdown also `ab`/`ib` and
  `` a` ``/`` i` `` code blocks.
- nvim-surround: `ys` adds, `ds` deletes, `cs` changes surroundings.
- `q` closes help, man, quickfix and checkhealth windows.
- Over SSH, yanks reach the local clipboard (OSC 52), but `p` pastes Neovim's own register: paste
  text copied outside Neovim with the terminal's paste key.

Inspired by [vhyrro](https://www.youtube.com/@vhyrro), [MrJakob](https://www.youtube.com/@MrJakob),
[theradlectures](https://www.youtube.com/@theradlectures) and
[joseanmartinez](https://www.youtube.com/@joseanmartinez).
