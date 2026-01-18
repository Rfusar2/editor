local key = vim.keymap.set
local opts = { noremap = true, silent = true }

local plug = my_global_vars.isWindows and "/csvlens.nvim/" or "/site/pack/packer/start/csvlens.nvim/"
local path = my_global_vars.data .. plug

require("csvlens").setup({
    direction = "float",
    exec_path = "csvlens",
    exec_install_path = path
})

-- Csv
key('n', "<leader>csv", ":Csvlens<CR>", opts)
-- Markdown
key('n', "<leader>mds", ":MarkdownPreview<CR>", opts)
key('n', "<leader>mdq", ":MarkdownPreviewStop<CR>", opts)
