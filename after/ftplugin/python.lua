-- Python runner keys (<leader> is Space), see lua/config/python_runner.lua.
-- ftplugin files run once per Python buffer, so no FileType autocmd is needed.
local runner = require("config.python_runner")

local function map(lhs, fn, desc)
  vim.keymap.set("n", lhs, fn, { buffer = true, desc = desc })
end

map("<leader>pr", runner.run_in_tmux, "Run current Python file in a tmux pane (selects pane on first run)")
map("<leader>ts", runner.select_pane, "Select a different target tmux pane")
map("<leader>pp", runner.run_and_show, "Run current Python file and show its output")
