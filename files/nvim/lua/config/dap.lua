local dap = require('dap')

dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = vim.fn.expand('~/mybin/codelldb/extension/adapter/codelldb'),
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

-- TODO: Will come back to this someday.
dap.configurations.cpp = {
{
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
