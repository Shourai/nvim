-- Autosave when leaving buffer or if focus is lost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  desc = "Autosave when leaving buffer or if focus is lost",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent update')
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
