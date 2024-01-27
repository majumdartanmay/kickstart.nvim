local function empty_map_table()
  local maps = {}
  for _, mode in ipairs { "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" } do
    maps[mode] = {}
  end
  if vim.fn.has "nvim-0.10.0" == 1 then
    for _, abbr_mode in ipairs { "ia", "ca", "!a" } do
      maps[abbr_mode] = {}
    end
  end
  return maps
end


local maps = empty_map_table();

maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
maps.n["<F21>"] = { -- Shift+F9
  function()
    vim.ui.input({ prompt = "Condition: " }, function(condition)
      if condition then require("dap").set_breakpoint(condition) end
    end)
  end,
  desc = "Debugger: Conditional Breakpoint",
}

maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11
maps.n["<leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
maps.n["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
maps.n["<leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
maps.n["<leader>dC"] = {
  function()
    vim.ui.input({ prompt = "Condition: " }, function(condition)
      if condition then require("dap").set_breakpoint(condition) end
    end)
  end,
  desc = "Conditional Breakpoint (S-F9)",
}
maps.n["<leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F11)" }
maps.n["<leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F10)" }
maps.n["<leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
maps.n["<leader>dq"] = { function() require("dap").close() end, desc = "Close Session" }
maps.n["<leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" }
maps.n["<leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
maps.n["<leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
maps.n["<leader>dR"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" }
maps.n["<leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }
maps.n["<leader>dE"] = {
  function()
    vim.ui.input({ prompt = "Expression: " }, function(expr)
      if expr then require("dapui").eval(expr, { enter = true }) end
    end)
  end,
  desc = "Evaluate Input",
}
maps.v["<leader>dE"] = { function() require("dapui").eval() end, desc = "Evaluate Input" }
maps.n["<leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }


for _, mode in ipairs { "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" } do
  for key, value in pairs(maps[mode]) do
    local funcBody = value[1];
    local desc = value.desc;
    vim.keymap.set(mode, key, funcBody, {noremap = true, silent = false, desc = desc });
  end
end
