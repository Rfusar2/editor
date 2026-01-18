local notify = require("notify")

notify.setup({
  fps=11,
  background_colour = "#000000",
  render = "default",
  stages = "fade",
  top_down = true,
})

local M = {}

M.log = function(msg, type, opts)
    if opts == "work" then 
        notify(msg, type, {
            on_close = function()
                local key = vim.api.nvim_replace_termcodes("<F2>", true, true, true)
                vim.fn.feedkeys(key, "")
            end
        })

    else notify([[


    ]]..msg..[[


]], type, opts)
    end
end
return M
