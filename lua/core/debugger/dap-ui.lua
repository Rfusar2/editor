local M = {}
local dap = require('dap')
local dapui = require('dapui')

local is_debug_server_running = false

local function update_status()
   local status = is_debug_server_running and "Debug Server: Running" or "Debug Server: Not Running"
   vim.api.nvim_set_var('debug_server_status', status)
end

function M.InitDapUi()
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      mappings = {
        expand = { "i", "<CR>" },
        open = "o",
        remove = "r",
        edit = "e",
        repl = "t",
        toggle = "t",
      },
      sidebar = {
        open_on_start = true,
        elements = {
          { id = "scopes", size = 0.4 },
        },
      },
      float = {
        max_height = 0.4,
        max_width = 0.5,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })
    
    -- Listener per quando il server di debug è avviato
    dap.listeners.after.event_initialized['dapui_config'] = function()
      is_debug_server_running = true
      update_status()
    end

    -- Listener per quando il server di debug è fermato
    dap.listeners.before.event_terminated['dapui_config'] = function()
      is_debug_server_running = false
      update_status()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      is_debug_server_running = false
      update_status()
      dapui.close()
    end
end

-- Mappature per i comandi di debug e stato del server
local opts = {noremap=true, silent=true}
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, opts)
vim.keymap.set('n', '<leader>db', function() require('dapui').float_element('breakpoints') end, opts)
vim.keymap.set('n', '<leader>dv', function() require('dapui').float_element('variables') end, opts)
vim.keymap.set('n', '<leader>ds', function() require('dapui').float_element('scopes') end, opts)

return M
