-- Python runner: run the current Python file in another tmux pane (<leader>pr) or show its
-- output in Neovim (<leader>pp). The keys are set in after/ftplugin/python.lua.
local M = {}

-- tmux pane ID (e.g. "%5") that <leader>pr sends to; nil until chosen with <leader>ts
local target_pane = nil

-- List the panes of the current tmux window and ask which one to send to.
-- Returns true when a pane was chosen.
function M.select_pane()
  print("Available Tmux Panes:")
  -- List the panes of the current window with their index, id, size and current command
  local obj = vim.system({ "tmux", "list-panes", "-F",
    "#{pane_index}: #{pane_id} #{pane_width}x#{pane_height} [running: #{pane_current_command}]" }):wait()
  if obj.code ~= 0 then
    print("Error: could not list tmux panes (not inside tmux?)")
    return false
  end

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

  -- Resolve the index to the pane ID in the current window
  local ids = vim.system({ "tmux", "list-panes", "-F", "#{pane_index} #{pane_id}" }):wait()
  local pane_id
  for index, id in (ids.stdout or ""):gmatch("(%d+) (%%%d+)") do
    if index == selected_index then
      pane_id = id
    end
  end
  if not pane_id then
    print("\nNo pane with index " .. selected_index .. " in this window. Target not set.")
    return false
  end

  target_pane = pane_id
  print("\nPython runner target set to pane " .. selected_index .. " (" .. pane_id .. "). Use <leader>pr to run code.")
  return true
end

-- Save and run the current file in the target pane, asking for a pane on first use
function M.run_in_tmux()
  local file_name = vim.api.nvim_buf_get_name(0)

  if not file_name:match("%.py$") then
    print("Not a valid Python file")
    return
  end

  vim.cmd.update()

  if not target_pane then
    print("Target pane not yet selected. Please select one below:")
    -- If selection fails (user cancels input), stop execution
    if not M.select_pane() then
      return
    end
  end

  -- Check if the target pane still exists (tmux 3.8 exits 0 with empty output for a missing pane)
  local exists = vim.system({ "tmux", "display-message", "-p", "-t", target_pane, "#{pane_id}" }):wait()
  if exists.code ~= 0 or vim.trim(exists.stdout or "") ~= target_pane then
    print("Error: Saved target pane " .. target_pane .. " no longer exists. Please use <Leader>ts to re-select.")
    target_pane = nil
    return
  end

  -- Clear the pane and run the file in one send-keys call
  vim.system({ "tmux", "send-keys", "-t", target_pane,
    "clear; python3 " .. vim.fn.shellescape(file_name), "Enter" })
end

-- Save and run the current file, printing its output (blocking)
function M.run_and_show()
  vim.cmd.update()
  print(vim.fn.system({ "python3", vim.fn.expand("%") }))
end

return M
