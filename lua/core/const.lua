local MY_GLOBAL_VARS = {}
MY_GLOBAL_VARS.__index = MY_GLOBAL_VARS

--constructor
function MY_GLOBAL_VARS:new(arg) 
    return setmetatable({
        home = vim.fn.stdpath('config'),
        log = vim.fn.stdpath('log'),
        data = vim.fn.stdpath('data'),
        isWindows = vim.loop.os_uname().sysname == "Windows_NT",
        isLinux = vim.loop.os_uname().sysname == "Linux",

    }, self)
end

--* open_url
function MY_GLOBAL_VARS:open_url(url)
    local cmd
    if vim.fn.has("mac") == 1 then cmd = { "open", url }
    elseif vim.fn.has("unix") == 1 then cmd = { "xdg-open", url }
    elseif vim.fn.has("win32") == 1 then cmd = { "cmd", "/c", "start", "", url }
    end
    if cmd then vim.fn.jobstart(cmd, { detach = true })
    end
end

--* restart_nvim
function MY_GLOBAL_VARS:restart_nvim()
    vim.cmd("wa")  -- salva tutti i file
    local current = vim.api.nvim_buf_get_name(0)
    vim.cmd("quitall!")
    vim.fn.jobstart({ "nvim", current }, { detach = true })
end


function MY_GLOBAL_VARS:log(obj) print(vim.inspect(obj)) end


function MY_GLOBAL_VARS:studies(keymap)
    if keymap == "text" then
        MY_GLOBAL_VARS:open_url("https://10fastfingers.com/typing-test/italian")
    else 
        print([[
keywords

text:   open link for text workout

        ]])
    end
end

_G.my_global_vars = MY_GLOBAL_VARS:new()
