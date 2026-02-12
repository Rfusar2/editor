local self_dir = vim.fn.getcwd()


_G.git_manager = {
    Backup = function(oldest_commit, newest_commit) 
        local output = vim.fn.system("git diff --color=always "..oldest_commit.." "..newest_commit)
        local lines = vim.fn.split(output, "\n")
        local filename = self_dir.."/DIFF_"..oldest_commit.."_"..newest_commit..".log"

        local file = io.open(filename, "w")
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
        filename = vim.fn.substitute(filename, "/", "\\", "g")
        vim.cmd("terminal type "..filename)
    end,

    Commits = function(name)
        if name == "" then
            print("Mandatory Params: name")
            return
        end
        local output = vim.fn.system("git log --format=%H,%cr")
        local lines = vim.fn.split(output, "\n")

        local file = io.open(self_dir.."/".. name ..".log", "w")
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
    end
}
