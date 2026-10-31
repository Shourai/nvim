-- Python runner: run the current Python file in another tmux pane (<leader>pr) or show its
-- output in Neovim (<leader>pp). The keys are set in after/ftplugin/python.lua.
local M = {}

-- tmux pane ID (e.g. "%5") that <leader>pr sends to; nil until chosen with <leader>ts
local target_pane = nil

-- List the panes of the current tmux window and ask which one to send to.
-- Returns true when a pane was chosen.
function M.select_pane()
  -- One tmux call both lists the panes (index, id, size, command) and maps index -> pane ID
  local res = vim.system({ "tmux", "list-panes", "-F",
    "#{pane_index} #{pane_id} #{pane_width}x#{pane_height} [running: #{pane_current_command}]" },
    { text = true }):wait()
  if res.code ~= 0 then
    print("Error: could not list tmux panes (not inside tmux?)")
    return false
  end

  print("Available Tmux Panes:")
  local ids = {} -- pane index (string) -> pane ID
  for index, id, rest in res.stdout:gmatch("(%d+) (%%%d+) ([^\n]*)") do
    ids[index] = id
    print(index .. ": " .. id .. " " .. rest)
  end

  local selected_index = vim.trim(vim.fn.input("Enter the target pane number (index): "))
  if selected_index == "" then
    print("\nSelection cancelled. Target not set.")
    return false
  end
  if not ids[selected_index] then
    print("\nNo pane with index '" .. selected_index .. "' in this window. Target not set.")
    return false
  end

  target_pane = ids[selected_index]
  print("\nPython runner target set to pane " .. selected_index .. " (" .. target_pane .. "). Use <leader>pr to run code.")
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

-- Save and run the current file; show stdout+stderr when it exits. Async, so Neovim
-- stays usable while the script runs (output ends up in :messages).
function M.run_and_show()
  vim.cmd.update()
  local file = vim.api.nvim_buf_get_name(0)
  vim.system({ "python3", file }, { text = true }, function(res)
    vim.schedule(function() -- vim.system callbacks run outside the main loop
      local out = vim.trim((res.stdout or "") .. (res.stderr or ""))
      vim.notify(out ~= "" and out or "(no output)",
        res.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
    end)
  end)
end

return M
