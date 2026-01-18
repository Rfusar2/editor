local dapui = require("core.debugger.dap-ui")
local dap = require("core.debugger.python")

dapui.InitDapUi()
dap.InitDap()


function helpFunc() 
    vim.lsp.buf.hover() 
    vim.cmd [[
        highlight NormalFloat guibg=#1e222a
        highlight FloatBorder guifg=#1f18db
        highlight @type guifg=#ff6c6b
        highlight @keyword guifg=#c678dd
        highlight @variable guifg=#98c379
    ]]
end

vim.keymap.set("n", "<M-d>", ":lua helpFunc()<CR>", {silent=true, noremap=true})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  style = "minimal"
})
