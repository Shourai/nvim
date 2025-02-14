-- Settings --

-------------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------

local opt = vim.opt -- global/buffer/windows-scoped options, see :h lua-vim-opt
local cmd = vim.cmd -- execute Vim commands
local g = vim.g -- global variables

-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = " " -- map leader to space
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.clipboard = "unnamed,unnamedplus" -- allow neovim to access the system clipboard
opt.swapfile = false -- creates a swapfile
opt.backup = false -- don't create backup file
opt.undofile = true -- save undo history to undo file

-----------------------------------------------------------
-- Clipboard support for OSC 52
-----------------------------------------------------------
if vim.env.SSH_TTY ~= nil then
	local function paste()
		return {
			vim.fn.split(vim.fn.getreg(""), "\n"),
			vim.fn.getregtype(""),
		}
	end

	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end
-----------------------------------------------------------
-- User Interface
-----------------------------------------------------------
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.ignorecase = true -- ignore case in search pattern
opt.smartcase = true -- smart case
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.lazyredraw = true

opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.termguicolors = true -- Enables 24 bit RGB colors in the TUI

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
-- insert mode completion options
opt.completeopt = "menu,menuone,noselect"

-----------------------------------------------------------
-- Misc
-----------------------------------------------------------

-- write file when focus is lost
cmd("autocmd FocusLost * silent! :wa")

-- write the contents of the file when jumping between jumppoints
opt.autowriteall = true

-- remove whitespace on save
-- cmd [[au BufWritePre * :%s/\s\+$//e]]
