local previewers = require('telescope.previewers')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local entry_display = require("telescope.pickers.entry_display")
local CONSTS = require('core.plugin.telescope.snippets.const')

local snippet_names = {}
for name, _ in pairs(CONSTS.snippets) do
  table.insert(snippet_names, name)
end

local M = {}

--* PREVIEWER
local custom_previewer = previewers.new_buffer_previewer {
  define_preview = function(self, entry, _)
    local file_path = CONSTS.snippets[entry.value]
    if vim.fn.filereadable(file_path) == 1 then
      local file = io.open(file_path, "r")
      local content = file:read("*all")
      file:close()
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(content, "\n"))
      local ext = file_path:match("^.+%.([a-zA-Z]+)$")
      local ft = ({
        py = "python",
        go = "go",
        html = "html",
        css = "css",
        js = "javascript",
        cs = "cs", -- csharp
      })[ext] or ""
      vim.bo[self.state.bufnr].filetype = ft
    else
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "File non disponibile o non leggibile" })
    end
  end
}

--* DISPLAY
local displayer = entry_display.create {
  separator = " ",
  items = {
    { width = 40 },
    { remaining = true },
  },
}

vim.api.nvim_set_hl(0, "GoLangSnippet", { fg = "#0EF0E8", bold = true, italic = true })
vim.api.nvim_set_hl(0, "JSSnippet",     { fg = "#F0C60E", bold = true, italic = true })
vim.api.nvim_set_hl(0, "PythonSnippet", { fg = "#0E0EF0", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CSharpSnippet", { fg = "#780EF0", bold = true, italic = true })

local make_display = function(entry)
  local hl
  if entry.value:match("^Golang") then hl = "GoLangSnippet"
  elseif entry.value:match("^Python") then hl = "PythonSnippet"
  elseif entry.value:match("^CSharp") then hl = "CSharpSnippet"
  elseif entry.value:match("^JS") then hl = "JSSnippet"
  else hl = "TelescopeResultsNormal"
  end

  return displayer {
    { entry.value, hl },
  }
end

function M.custom_picker()
  pickers.new({
    prompt_title = "Scegli Snippets",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 0.8,
      },
      width = 0.8,
      height = 0.7,
    },
    finder = finders.new_table {
      results = snippet_names,
      entry_maker = function(entry)
        return {
          value = entry,
          ordinal = entry,
          display = make_display,
        }
      end
    },
    previewer = custom_previewer,
    sorter = require('telescope.config').values.generic_sorter({}),
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local file_path = CONSTS.snippets[selection.value]
        local file = io.open(file_path, "r")
        if file then
          local content = file:read("*all")
          file:close()
          vim.fn.setreg('+', content)
        end
      end)
      return true
    end,
  }):find()
end

return M
