local ls = require("luasnip")

-- VSCode snippet loader
--require("luasnip.loaders.from_vscode").load({
--    paths = { "C:/Users/Utente/AppData/Local/nvim/snippets/vscode/" }
--})

-- SnipMate loader
require("luasnip.loaders.from_snipmate").load({
    paths = { vim.fn.stdpath("config") .. "/snippets/snipmate" }
})

vim.keymap.set("i", "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set("i", "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set("i", "<C-J>", function() ls.jump(-1) end, {silent = true})
