-- Autosave on leaving a buffer or losing focus, so unsaved changes never stay only in memory
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  desc = "Autosave modified file buffers",
  group = vim.api.nvim_create_augroup("autosave_on_leave_group", { clear = true }),
  callback = function(args)
    local bo = vim.bo[args.buf]
    -- Only real, writable files with a name and unsaved changes
    if not (bo.modified and bo.buftype == "" and not bo.readonly and vim.api.nvim_buf_get_name(args.buf) ~= "") then
      return
    end
    -- Mark as autosave so conform skips formatting (lua/plugins/conform.lua): switching
    -- windows shouldn't wait on prettier/ansible-lint. Explicit :w still formats.
    vim.b[args.buf].autosaving = true
    local ok, err = pcall(vim.cmd.update, { mods = { silent = true } })
    vim.b[args.buf].autosaving = nil
    if not ok then
      vim.notify("Autosave failed: " .. err, vim.log.levels.WARN)
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
    -- Skip git commit/rebase messages and xxd, as in :h restore-cursor. The filetype may not
    -- be set yet when BufReadPost fires, so the git files are also matched by name.
    local name = vim.fs.basename(vim.api.nvim_buf_get_name(args.buf))
    if vim.tbl_contains({ "gitcommit", "gitrebase", "xxd" }, vim.bo[args.buf].filetype)
        or vim.tbl_contains({ "COMMIT_EDITMSG", "git-rebase-todo" }, name) then
      return
    end

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

-- Prevents o/O and Enter from inheriting the comment leader
-- Except in help buffers, which keep comment continuation (gitcommit's ftplugin already removes c/r/o).
-- (Autocmd patterns can't exclude filetypes with "!", so the check is in the callback.)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NoAutoComment", { clear = true }),
  callback = function(args)
    if args.match == "help" then
      return
    end
    -- Remove the 'c', 'r', and 'o' flags for this buffer only
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Use q to close help-like buffers
vim.api.nvim_create_autocmd("FileType", {
  desc = "Use q to close help-like buffers",
  group = vim.api.nvim_create_augroup("q-close", { clear = true }),
  pattern = { "help", "man", "qf", "checkhealth" }, -- :LspInfo opens a checkhealth buffer in 0.12
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
    vim.bo.buflisted = false
  end,
})
