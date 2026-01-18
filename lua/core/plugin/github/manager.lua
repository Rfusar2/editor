local M = {}

local C_GIT = {}
C_GIT.__index = C_GIT

--constructor
function C_GIT:new() 
    return setmetatable({
        dir = my_global_vars.home.."/lua/core/plugin/github/git_history",


    }, self)
end

function C_GIT:backup(oldest_commit, newest_commit)
    local output = vim.fn.system("git diff --color=always "..oldest_commit.." "..newest_commit)
    local lines = vim.fn.split(output, "\n")
    local filename = self.dir.."/DIFF_"..oldest_commit.."_"..newest_commit..".log"

    local file = io.open(filename, "w")
    for _, line in ipairs(lines) do
        file:write(line .. "\n")
    end
    file:close()
    filename = vim.fn.substitute(filename, "/", "\\", "g")
    vim.cmd("terminal type "..filename)
end

function C_GIT:commits()

    local output = vim.fn.system("git log --format=%H,%cr")
    local lines = vim.fn.split(output, "\n")

    local file = io.open(self.dir.."/ID_COMMITS.log", "w")
    for _, line in ipairs(lines) do
        file:write(line .. "\n")
    end
    file:close()
end

function C_GIT:start()
    vim.cmd("cd "..self.dir)
    vim.cmd("edit "..self.dir)
end


M.git_manager = C_GIT:new()

return M
