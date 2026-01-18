local p = require('telescope.pickers')
local t = require("telescope.themes")
local f = require("telescope.finders")
local c = require('telescope.config')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local lib = require("core.plugin.telescope.docs.const")
local home = vim.fn.stdpath('config') .. "/lua/core/plugin/telescope/docs"

local M = {}

function AddTable(table_IN, table_OUT)
    for k, _ in pairs(table_IN) do table.insert(table_OUT, k) end
end

function Menu(title, selections, function_after_selection)
    p.new(t.get_dropdown({}), {
        prompt_title = title,
        finder = f.new_table { results = selections },
        sorter = c.values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            return function_after_selection(prompt_bufnr)
        end,
    }):find()
end

-- crea menu principale
local Menu_1 = {}
local Menu_2 = {}
AddTable(lib.DOC_LINKS, Menu_1)

local last_selection = nil

function M.custom_picker()
    Menu("Docs", Menu_1, function(prompt_bufnr, _)
        actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            Menu_2 = {}
    
            local category = selection[1]
            local sub_links = lib.DOC_LINKS[category]
            
            if type(sub_links) == "string" then
                if category:match("Add New Doc Page") then
                    vim.cmd("edit " .. vim.fn.fnameescape(home .. "/const.lua"))
                    return true
                end
                my_global_vars:open_url(sub_links)
                return true
            end
    
            AddTable(sub_links, Menu_2)
            Menu(category, Menu_2, function(sub_bufnr, _)
                actions.select_default:replace(function()
                    local sub_selection = action_state.get_selected_entry()
                    actions.close(sub_bufnr)
                    my_global_vars:open_url(lib.DOC_LINKS[category][sub_selection[1]])
                end)
                return true
            end)
        end)
        return true
    end)
end

return M
