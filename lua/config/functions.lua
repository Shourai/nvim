function RunPythonInTmux()
  -- Get the current buffer's file name
  local file_name = vim.api.nvim_buf_get_name(0)

  -- Check if the file name is empty or not a Python file
  if file_name == "" or not file_name:match("%.py$") then
    print("Not a valid Python file")
    return
  end

  -- The command to run the python file. Use 'python3' or 'python' as appropriate.
  local run_cmd = "python3 " .. vim.fn.shellescape(file_name) .. "\n"

  -- Send the command to the next tmux pane relative to the current one.
  -- The target pane is specified using the relative index ":.+".
  vim.fn.system({ "tmux", "send-keys", "-t", ":.+", run_cmd })
  -- Optional: switch focus to the output pane temporarily to show execution
  -- vim.fn.system({ "tmux", "select-pane", "-t", ":.+" })
  -- -- Optional: switch focus back to the Neovim pane
  -- vim.fn.system({ "tmux", "select-pane", "-t", ":.-" }) -- Use ":.-" for the previous pane (which was the source)
end

-- Set a keymap in normal mode (e.g., <Leader>r) to run the function
vim.api.nvim_set_keymap('n', ',r', ':lua RunPythonInTmux()<CR>',
  { noremap = true, silent = true, desc = "Run current Python file in next tmux pane" })
