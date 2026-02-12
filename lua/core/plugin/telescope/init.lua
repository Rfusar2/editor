local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")
local pickers = require('telescope.pickers')
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values
local MP = require("core.plugin.telescope.changeProject.menuProject")
local SNI_M = require("core.plugin.telescope.snippets.menu")
local DOC_M = require("core.plugin.telescope.docs.menu")

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<leader>h"] = function(prompt_bufnr)
          actions.close(prompt_bufnr)
          MyCustomMenu()
        end,
        ["<C-f>"] = function(prompt_bufnr)
            actions.close(prompt_bufnr)
            builtin.find_files()
        end,


        -- GIT
        ["<leader>gc"] = function(prompt_bufnr)
          actions.close(prompt_bufnr)
          builtin.git_commits()  -- o un altro picker
        end,
        ["<leader>gb"] = function(prompt_bufnr)
            actions.close(prompt_bufnr)
            builtin.git_branches()  -- o un altro picker
        end,
        ["<leader>gs"] = function(prompt_bufnr)
          actions.close(prompt_bufnr)
          builtin.git_status()  -- o un altro picker
        end,
      }
    }
  }
}
function MyCustomMenu()
    pickers.new(require("telescope.themes").get_dropdown({  
        layout_config = {
            height = 20,
            width = 70,
        }
    }), 
    {
      prompt_title = "Documentazione",
      finder = finders.new_table {
        results = {""}, -- finta entry
      },
      previewer = previewers.new_buffer_previewer {
        define_preview = function(self, _)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split([[

    ## MENU HELP  ##

This page      ->  leader + h
ColorSchemas   ->  ctrl + c
Files          ->  ctrl + f

GIT

  leader + gc  | Git Commit        
  leader + gb  | Git Braches       
  leader + gs  | Git Status        
  
]], "\n"))
        end,
      },
      sorter = require("telescope.sorters").empty(),
      attach_mappings = function() return true end,
    }):find()
end


-- KEY MAPS
vim.keymap.set("", "<leader>p", ":lua MyCustomMenu()<CR>", opt)

vim.keymap.set("", "<leader>k", function() builtin.live_grep() end, opt)
vim.keymap.set("", "<leader>j", function() builtin.buffers() end, opt)

-- DOC
vim.keymap.set('', '<leader>doc', function() DOC_M.custom_picker() end, opt)

-- SNIPPETS
vim.keymap.set('', '<leader>sni', function()  SNI_M.custom_picker() end, opts)

-- PROJECTS
vim.keymap.set('', '<C-p>', function() MP.MenuProject() end, opt)
