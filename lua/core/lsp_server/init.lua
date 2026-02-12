require("core.lsp_server.snippets")

local cmp = require("cmp")
local luasnip = require("luasnip")

--! Setup nvim-cmp
cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = {
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<M-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = "luasnip", keyword_length = 0 },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer", keyword_length = 2 },
    },
})

require("mason").setup()

_G.HELPS = require("core.lsp_server.server").Server_LSP:new()

--! Stato LSP
function vim.g.StopLSP()
    for _, client in ipairs(vim.lsp.get_clients()) do
        client.stop()
    end
end


