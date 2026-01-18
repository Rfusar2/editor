local L = require("core.notify")

function pushGithub(branch, namespace, comment)
    -- Validate commit message
    if comment == "" then
        L.log("Commit message cannot be empty!", "error", {timeout=10000})
        return
    end
    -- Escape quotes in commit message
    comment = comment:gsub('"', '\\"')
    
    -- Execute git commands with error handling
    local add_result = vim.fn.system('git add .')
    if vim.v.shell_error ~= 0 then
        L.log("Error adding files: "..add_result, "error", {timeout=10000})
        return
    end
    
    local commit_result = vim.fn.system({ "git", "commit", "-m", comment })
    if vim.v.shell_error ~= 0 then
        L.log("Error committing: "..commit_result, "error", {timeout=10000})
        return
    end
    

    local push_result = vim.fn.system({"git", "push", "-f", namespace, branch})
    if vim.v.shell_error ~= 0 then
        L.log("Error pushing: "..push_result, "error", {timeout=10000})
        return
    end
    
    L.log("Successfully pushed to "..namespace.."/"..branch, "info", {timeout=500})
end

function addZero(value)
    local v = tostring(value)
    if #v == 1 then return "0"..v 
    else return v
    end
end

vim.api.nvim_create_user_command(
  "PushGithub",
  function(opts)
    if opts.args == "nvim" then
        local now = os.date("*t")
        local comment = addZero(now["day"]).."-"..addZero(now["month"]).."-"..now["year"]
        pushGithub("master", "origin", comment)
    else
        local args = vim.split(opts.args, ", ")
        pushGithub(args[1], args[2], args[3])
    end
  end,
  { nargs = 1 }
)
