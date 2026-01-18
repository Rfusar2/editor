local M = {}

M.Server_LSP = {}
M.Server_LSP.__index = M.Server_LSP

--* constructor
function M.Server_LSP:new()
    return setmetatable({
        servers = {
            python = { patterns = { "*.py" }, name = "pyright", exec = "/pyright-langserver.cmd" },
            typescript = { patterns = { "*.js", "*.ts" }, name = "ts_ls", exec = "/typescript-language-server.cmd" },
        },
    }, self)
end

--* start
function M.Server_LSP:start(server_name, cmd)
    vim.lsp.start({
        name = server_name,
        cmd = { cmd, "--stdio" },
        capabilities = require("cmp_nvim_lsp")
            .default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    })
    require("notify")(server_name .. " ATTIVATO")
end

--* active
function M.Server_LSP:active()
    local home = vim.fn.stdpath("data") .. "/mason/bin"
    for _, server in pairs(self.servers) do
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = server.patterns,
            callback = function()
                if #vim.lsp.get_clients() == 0 then
                    self:start(server.name, home .. server.exec)
                end
            end,
        })
    end
end

return M
