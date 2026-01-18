local M = {}
local dap = require('dap')
local log = require("core.notify")

local function get_python_path()
    local venv_path = my_global_vars.isWindows and '/venv/Scripts/python.exe' or '/venv/bin/python3'
    local venv_path_log = my_global_vars.isWindows and "Sono su windows ed è presente il venv" or "Sono su Unix-like ed'è presente il venv"
    
    local VENV = vim.fn.getcwd()..venv_path

    if vim.fn.executable(VENV) == 1 then
        log.log(venv_path_log, "info", {})
        return venv_path
    end
    log.log("m'attacco al python di sistema per il debug", "info", {} )
    return my_global_vars.isWindows and 'C:/Users/Utente/AppData/Local/Programs/Python/Python310/python.exe' or '/usr/bin/python3'
end

function M.InitDap()
    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
          type = 'server',
          port = assert(port, '`connect.port` is required for a python `attach` configuration'),
          host = host,
          options = {
            source_filetype = 'python',
          },
        })
      else
        cb({
          type = 'executable',
          command = get_python_path(),  -- Usa la funzione per ottenere il percorso
          args = { '-m', 'debugpy.adapter' },
          options = {
            source_filetype = 'python',
          },
        })
      end
    end
    
    dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return get_python_path()  -- Usa la funzione per ottenere il percorso
        end;
      },
    }
    
    local opts = {noremap=true, silent=true}
    vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, opts) 
    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, opts)
    vim.keymap.set('n', '<F5>', function() dap.continue() end, opts)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, opts)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, opts)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, opts)
end

return M
