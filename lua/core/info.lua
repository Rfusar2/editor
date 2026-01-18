local p = require("packer")
local n = require("core.networks")

local WINDOWS = {"choco", "python", "npm"}
local LINUX = {"wget", "python3", "npm"}

local dep = my_global_vars.isWindows and WINDOWS or LINUX

_G.custom_editor_status = {
    ShowPlugs = function () 
        for name, plugin in pairs(packer_plugins) do
            if plugin.loaded then print(name)
            else print(name.." ------------> !!! NON INSTALLATO !!!")
            end
        end
    end,

    StatusConnections = n.myinterfaces,

    CheckEnv = function() 
        for _, tool in ipairs(dep) do
            local is_installed = vim.fn.executable(tool) == 1
            if is_installed then
                require("notify")(tool .. " è installato", "info", {title = "Dependency Check", timeout = 1000})
            else
                require("notify")(tool .. " non è installato", "error", {title = "Dependency Check", timeout = 1000})
            end
        end
    end,

    ViewHistoryGit = function() 
        vim.cmd("cd "..my_global_vars.home .. "/lua/core/plugin/github")
        vim.cmd("edit .")
        vim.cmd("edit init.lua")
    end,

    Update = function (name)
        vim.cmd(":edit "..my_global_vars.home.."/lua/core/packer.lua")
        vim.cmd(":wa!")
        vim.cmd(":so %")
        if name == "" then p.sync()
        else p.update(name)
        end
    end,
    
    LogPlugin = function ()
        local logs = {}
        for i, file in ipairs(vim.fn.glob(my_global_vars.log.."/*.log",1, 1)) do
            local label = (vim.fn.getfsize(file) > 0) and "   DA CONTROLLARE" or ""
            logs[i] = file .. label
        end

        for _, l in ipairs(logs) do print(l) end
    end,

    ClearLogs = function ()
        for _, file in ipairs(vim.fn.glob(my_global_vars.log.."/*.log",1, 1)) do
            local file = io.open(file, "w")
            file:write("")
            file:close()
        end

    end,
}
