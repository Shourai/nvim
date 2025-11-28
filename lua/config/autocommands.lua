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
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})


-- remove whitespace on save
-- cmd [[au BufWritePre * :%s/\s\+$//e]]
