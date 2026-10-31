-- Settings --

-------------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------

local opt = vim.opt -- global/buffer/windows-scoped options, see :h lua-vim-opt
local g = vim.g     -- global variables

-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = " "                     -- map leader to space
g.maplocalleader = "\\"               -- set before lazy.setup() so plugin <localleader> maps use it
opt.mouse = "a"                       -- allow the mouse to be used in neovim
opt.clipboard = "unnamed,unnamedplus" -- allow neovim to access the system clipboard
opt.swapfile = false                  -- creates a swapfile
opt.backup = false                    -- don't create backup file
opt.undofile = true                   -- save undo history to undo file

-----------------------------------------------------------
-- Clipboard support for OSC 52
-----------------------------------------------------------
-- Over SSH, copy to the local clipboard with OSC 52 but paste from Neovim's own register:
-- OSC 52 *reads* block for up to 10 s on terminals that don't answer them. Use the
-- terminal's paste (Ctrl-Shift-V / Cmd-V) for text copied outside Neovim.
if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function paste()
    return { vim.fn.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"') }
  end
  vim.g.clipboard = {
    name = "OSC 52 (copy only)",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end
-----------------------------------------------------------
-- User Interface
-----------------------------------------------------------
opt.conceallevel = 0       -- so that `` is visible in markdown files
opt.ignorecase = true      -- ignore case in search pattern
opt.smartcase = true       -- smart case
opt.splitbelow = true      -- force all horizontal splits to go below current window
opt.splitright = true      -- force all vertical splits to go to the right of current window

opt.cursorline = true     -- highlight the current line
opt.number = true         -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.termguicolors = true  -- Enables 24 bit RGB colors in the TUI
opt.showmode = false      -- don't show mode as it's already in the status line
opt.scrolloff = 5         -- Minimal number of screen lines to keep above and below the cursor.

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- convert tabs to spaces
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
-- Native insert-mode completion menu (Ctrl-N / Ctrl-X); blink.cmp draws its own
opt.completeopt = "menu,menuone,noselect"

-----------------------------------------------------------
-- Misc
-----------------------------------------------------------

-- Write modified buffers instead of refusing on :q, :e, :buffer, CTRL-^, CTRL-O to another file.
-- Together with the autosave autocmd, edits are never kept only in memory.
-- Note: :q on a modified buffer saves (and formats) without asking.
opt.autowriteall = true
