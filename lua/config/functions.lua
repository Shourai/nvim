-- Global variable to store the selected target pane ID (e.g. "%5")
if vim.g.python_tmux_target_pane == nil then
  vim.g.python_tmux_target_pane = "" -- Empty string means unset
end

-- Function to list panes and prompt the user for selection
local function select_tmux_target_pane()
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

  -- Store the pane ID globally
  vim.g.python_tmux_target_pane = pane_id
  print("\nPython runner target set to pane " .. selected_index .. " (" .. pane_id .. "). Use <leader>pr to run code.")
  return true
end

-- Main function to run the Python script
local function run_python_in_tmux()
  local file_name = vim.api.nvim_buf_get_name(0)

  if not file_name:match("%.py$") then
    print("Not a valid Python file")
    return
  end

  vim.cmd.update()

  -- === Check if the target is set, if not, call the selection function ===
  if vim.g.python_tmux_target_pane == "" then
    print("Target pane not yet selected. Please select one below:")
    -- If selection fails (user cancels input), stop execution
    if not select_tmux_target_pane() then
      return
    end
  end

  local target_pane = vim.g.python_tmux_target_pane

  -- Check if the target pane still exists (tmux 3.8 exits 0 with empty output for a missing pane)
  local exists = vim.system({ "tmux", "display-message", "-p", "-t", target_pane, "#{pane_id}" }):wait()
  if exists.code ~= 0 or vim.trim(exists.stdout or "") ~= target_pane then
    print("Error: Saved target pane " .. target_pane .. " no longer exists. Please use <Leader>ts to re-select.")
    vim.g.python_tmux_target_pane = "" -- Reset the flag
    return
  end

  -- Clear the pane and run the file in one send-keys call
  vim.system({ "tmux", "send-keys", "-t", target_pane,
    "clear; python3 " .. vim.fn.shellescape(file_name), "Enter" })
end

-- Python runner keys (<leader> is Space), only in Python buffers
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("PythonRunner", { clear = true }),
  pattern = "python",
  callback = function(args)
    vim.keymap.set("n", "<leader>pr", run_python_in_tmux,
      { buffer = args.buf, silent = true, desc = "Run current Python file in a tmux pane (selects pane on first run)" })

    vim.keymap.set("n", "<leader>ts", select_tmux_target_pane,
      { buffer = args.buf, silent = true, desc = "Manually select a different target tmux pane number" })

    vim.keymap.set("n", "<leader>pp", function()
      vim.cmd.update()
      print(vim.fn.system({ "python3", vim.fn.expand("%") }))
    end, { buffer = args.buf, silent = true, desc = "Run current Python file and show its output (blocking)" })
  end,
})
