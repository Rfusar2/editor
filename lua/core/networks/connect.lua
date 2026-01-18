function _G.my_connector(cmd, network_name)
    if cmd == "show" then
        local result = vim.system({ "netsh", "wlan", "show", "networks" }):wait()
        print(result.stdout)

    elseif cmd == "set" then
        local result =local result =  vim.system({"netsh", "wlan", "connect", network_name}):wait()
    end
end
