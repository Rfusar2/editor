local dir = my_global_vars.home.."/lua/core/networks"
local M = {}

function M.myinterfaces()
    local result = vim.fn.system(dir .. "/networks.exe ".."")
    local file = io.open(dir .. "/result.log", "w")

    file:write(result)
    file:close()
    vim.cmd("edit "..dir.."/result.log")
    
    vim.fn.delete(dir.."/result.log")
end

return M
