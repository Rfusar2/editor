local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local themes = require('telescope.themes')
local C = require("core.plugin.telescope.changeProject.const")

local M = {}

local MenuSelect = {}
for k, _ in pairs(C.projects) do table.insert(MenuSelect, k) end


function M.MenuProject()
  pickers.new(themes.get_dropdown({}), {
    prompt_title = "Menu Project",
    finder = finders.new_table({
      results = MenuSelect,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        if selection then
          local key = selection.value
          local path = C.projects[key]
          if path then
              if key:match("FUNC -") then 

                if key:match("Add New Path") then 
                    local file_config = vim.fn.fnameescape(vim.fn.stdpath('config').."/lua/core/plugin/telescope/changeProject/const.lua")
                    vim.cmd("edit ".. file_config)

                elseif key:match("Add New Script") then 
                    local file_config = vim.fn.fnameescape(vim.fn.stdpath('config').."/lua/core/plugin/telescope/scripts/")
                    vim.cmd("edit ".. file_config)
                
                elseif key:match("Add New Snippet") then 
                    local file_config = vim.fn.fnameescape(vim.fn.stdpath('config').."/lua/core/plugin/telescope/snippets/")
                    vim.cmd("edit ".. file_config)

                elseif key:match("Copy Current Directory") then 
                    vim.fn.setreg("+", vim.fn.expand("%:p"))
                
                end

              else
                require("nvim-tree.view").close()
                vim.cmd("lcd " .. vim.fn.fnameescape(path))
                vim.cmd("edit .")
              end
          end
        end
      end)
      return true
    end,
  }):find()
end

-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("", "<leader>ps", ":lua MenuProject()<CR>", opts)

return M
