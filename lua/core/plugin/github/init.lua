local self_dir = vim.fn.getcwd()
local folder = "git-history"

function createFolder()
    local ok = os.execute("mkdir "..folder)
    if not ok then
        print("Errore nella creazione della cartella")
    end
end

_G.git_manager = {
    Backup = function(oldest_commit, newest_commit) 
        createFolder()
        local output = vim.fn.system("git diff --color=always "..oldest_commit.." "..newest_commit)
        local lines = vim.fn.split(output, "\n")
        local filename = self_dir.."/"..folder.."/DIFF_"..oldest_commit.."_"..newest_commit..".log"

        local file = io.open(filename, "w")
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
        filename = vim.fn.substitute(filename, "/", "\\", "g")
    end,

    View = function(filename)
        vim.cmd("terminal type "..filename)
    end,

    Help = function()
        print("HELP git_manager")
        print("COMMITS: ")
        print("BACKUP: ")
    end,

    Commits = function(name)
        createFolder()
        if name == "" then
            print("Mandatory Params: name")
            return
        end
        local output = vim.fn.system("git log --format=%H,%cr")
        local lines = vim.fn.split(output, "\n")

        local file = io.open(self_dir.."/"..folder.."/".. name ..".log", "w")
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
    end
}
