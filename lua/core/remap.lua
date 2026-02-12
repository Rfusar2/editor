vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
if _G.my_global_vars.isWindows then vim.opt.clipboard = 'unnamedplus' end
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'              

-- Tab
vim.opt.tabstop = 4          
vim.opt.softtabstop = 4             
vim.opt.shiftwidth = 4             
vim.opt.expandtab = true    

-- UI config
vim.opt.number = true      
vim.opt.relativenumber = true     
vim.opt.cursorline = true    
vim.opt.splitbelow = true    
vim.opt.splitright = true   

-- Manage folders
vim.o.viewoptions = "folds,cursor"
vim.cmd [[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave * silent! mkview
    autocmd BufWinEnter * silent! loadview
  augroup END
]]

-- Clipboard management 
vim.opt.shortmess:append("c")
vim.api.nvim_create_augroup("autoreload", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = "autoreload",
    command = "checktime"
})

local key = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymap = {
    save = {
        {"", "<C-s>", ":w!<CR>"},
        {"", "<leader>sa", ":wa!<CR>"},
        {"v", "<leader>c", '"+y'},
    },
    layout = {
        {"n", "<M-,>", "<c-w>5<"},
        {"n", "<M-.>", "<c-w>5>"},
        {"n", "<M-u>", "<C-W>-"},
        {"n", "<M-d>", "<C-W>+"},
        {"n", "<C-b>", ":NvimTreeToggle<CR>"},
    }
}

for _, group in pairs(keymap) do
    for _, k in ipairs(group) do
        key(k[1], k[2], k[3], opt)
    end
end

key("", "<leader>123", function() vim.opt.number = true; vim.opt.relativenumber = false end, opts)
key("", "<leader>101", function() vim.opt.relativenumber = true; vim.opt.number = false end, opts)


--* Registries
function CleanRegistries()
    local registers = { 
        '"', '0', '1', '2', '3', '4', '5','6', '7', '8', '9', 'a', 'b', 'c', 
        'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p','s', 'u', 'v', 'x', 
        'y', 'z', '*', '+'
    }
    for _, reg in ipairs(registers) do
        vim.fn.setreg(reg, '')
    end
    require("notify")('Pulizia Registri completata', 'info', {timeout=1000})
end
function CleanSearch() vim.fn.setreg("/", '') end


--* GIT E ETC CONFIG
local keymap_with_leader_all_mode = {
    ["1"] = 'require("telescope.builtin").colorscheme()',

    ["5"] = 'require("telescope.builtin").git_status()',
    ["6"] = 'require("telescope.builtin").git_commits()',
    ["7"] = 'require("telescope.builtin").git_branches()',

    ["s"] = 'require("telescope.builtin").live_grep({path_display="hidden"})',
    ["crs"] = 'CleanSearch()',
    ["cr"] = 'CleanRegistries()',
    ["fh"] = "require('telescope.builtin').help_tags()",
}
for i, v in pairs(keymap_with_leader_all_mode)
do
    key("", "<leader>"..i, ":lua "..v.."<CR>", {})
end

--* Shells
local shell = _G.my_global_vars.isWindows and 'term://cmd' or 'term://bin/bash'
local shell_py = _G.my_global_vars.isWindows and 'term://python' or 'term://bin/python3'
local keymap_with_leader_all_mode = {
    ["1"] = function() vim.cmd("vsplit "..shell) end,
    ["2"] = function() vim.cmd("vsplit "..shell_py) end,
}
for i, v in pairs(keymap_with_leader_all_mode)
do
    key("", "<M-"..i..">", v, {})
end
