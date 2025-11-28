-- Autosave when leaving buffer or if focus is lost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  desc = "Autosave modified buffers when focus is lost or buffer is left",
  -- Define and clear the augroup inline
  group = vim.api.nvim_create_augroup("autosave_on_leave_group", { clear = true }),
  callback = function(args)
    -- Check if:
    -- 1. The buffer has modifications (is 'dirty')
    -- 2. The buffer is a normal, writable file type (not help, terminal, etc.)
    -- 3. The file is considered writable by Neovim (has a name, not readonly)
    if vim.bo.modified and vim.bo.buftype == "" and vim.is_writable(args.buf) then
      -- Use 'update' which only writes the file if changes were made
      vim.cmd('silent update')
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Jump to last editing locations
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Auto jump to last position",
  group = vim.api.nvim_create_augroup("auto-last-position", { clear = true }),
  callback = function(args)
    -- Get the mark for the specific buffer that triggered the event
    local line, col = unpack(vim.api.nvim_buf_get_mark(args.buf, [["]]))
    local line_count = vim.api.nvim_buf_line_count(args.buf)

    -- Validate position: Must be a line > 0 and within the file boundary
    if line > 0 and line <= line_count then
      -- Set cursor in the CURRENT window (0 refers to the current/active window)
      pcall(vim.api.nvim_win_set_cursor, 0, { line, col })

      -- Optional: Center the view on the cursor position
      vim.cmd("normal! zvzz")
    end
  end,
})

-- Prevents o/O from inheriting comment leader
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NoAutoComment", { clear = true }),
  -- The 'pattern' defines *which* file types this applies to.
  -- '*': Apply this to all file types by default.
  -- '!gitcommit': EXCEPT the git commit message buffer, where you DO want auto comments.
  -- '!NvimTree': EXCEPT file tree views.
  -- '!help': EXCEPT help files.
  -- '!markdown': You might keep this on for prose/documentation writing.
  pattern = { "*", "!gitcommit", "!NvimTree", "!help" },
  callback = function()
    -- Set the buffer-local option to remove the 'c', 'r', and 'o' flags
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

-- Use q to close help-like buffers
vim.api.nvim_create_autocmd("FileType", {
  desc = "Use q to close help-like buffers",
  group = vim.api.nvim_create_augroup("q-close", { clear = true }),
  pattern = { "help", "man", "qf", "lspinfo", "fugitive" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
    vim.bo.buflisted = false
  end,
})

-- vim.api.nvim_create_autocmd("InsertEnter", {
--   desc = "Disable relative numbers in insert",
--   callback = function() vim.opt.relativenumber = false end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   desc = "Enable relative numbers in normal mode",
--   callback = function() vim.opt.relativenumber = true end,
-- })
--
-- remove whitespace on save
-- cmd [[au BufWritePre * :%s/\s\+$//e]]
