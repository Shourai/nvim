-- Global variable to store the selected target pane index
if vim.g.python_tmux_target_pane_index == nil then
  vim.g.python_tmux_target_pane_index = "" -- Empty string means unset
end

-- Function to list panes and prompt the user for selection
function SelectTmuxTargetPane()
  print("Available Tmux Panes:")
  -- Get a list of panes with their index, size, and current command using modern vim.system
  local obj = vim.system({ "tmux", "list-panes", "-F",
    "#{pane_index}: #{pane_width}x#{pane_height} [running: #{pane_current_command}" }):wait()

  -- Print each pane info to the messages buffer
  for line in obj.stdout:gmatch("[^\n]+") do
    print(line)
  end

  -- Prompt the user to input the desired index
  local selected_index = vim.fn.input("Enter the target pane number (index): ")

  -- Validate input
  if selected_index == "" or tonumber(selected_index) == nil then
    print("Invalid input or selection cancelled. Target not set.")
    return false
  end

  -- Store the valid index globally
  vim.g.python_tmux_target_pane_index = selected_index
  print("\nPython runner target set to pane index: " .. selected_index .. ". Use <,r> to run code.")
  return true
end

-- Main function to run the Python script
function RunPythonInTmux()
  local file_name = vim.api.nvim_buf_get_name(0)

  if not file_name:match("%.py$") then
    print("Not a valid Python file")
    return
  end

  -- === Check if the target is set, if not, call the selection function ===
  if vim.g.python_tmux_target_pane_index == "" then
    print("Target pane not yet selected. Please select one below:")
    -- If selection fails (user cancels input), stop execution
    if not SelectTmuxTargetPane() then
      return
    end
  end

  -- Use the stored target pane index
  local target_pane = vim.g.python_tmux_target_pane_index
  local run_cmd = "python3 " .. vim.fn.shellescape(file_name) .. "\n"

  -- Check if the target pane actually exists using vim.system
  local pane_exists_obj = vim.system({ "tmux", "list-panes", "-t", target_pane }):wait()
  if pane_exists_obj.code ~= 0 then
    print("Error: Saved target pane " .. target_pane .. " no longer exists. Please use <Leader>ts to re-select.")
    vim.g.python_tmux_target_pane_index = "" -- Reset the flag
    return
  end

  -- Execute commands in the determined target pane
  vim.system({ "tmux", "send-keys", "-t", target_pane, "clear", "Enter" })
  vim.system({ "tmux", "send-keys", "-t", target_pane, run_cmd })
end

vim.api.nvim_set_keymap('n', ',r', ':lua RunPythonInTmux()<CR>', {
  noremap = true,
  silent = true,
  desc = "Run current Python file (selects pane on first run)"
})

vim.api.nvim_set_keymap('n', '<Leader>ts', ':lua SelectTmuxTargetPane()<CR>', {
  noremap = true,
  silent = true,
  desc = "Manually select a different target tmux pane number"
})

vim.api.nvim_set_keymap('n', ',pr', ':lua print(vim.fn.system("python3 " .. vim.fn.expand("%")))<CR>',
  { noremap = true, silent = true, desc = "Run Python file (blocking)" })
