function checkfile(path)
    local f = io.open(path, "r")

    if not f then io.open(path, "w")
    end
end

local function open_file_in_split(file_path)
    local file = io.open(file_path, "r")
    if file then
        file:close()
        vim.cmd('aboveleft split ' .. file_path)  -- Apri il file in split sopra
        vim.cmd('resize 20')
    else
        print("Errore: Impossibile aprire il file " .. file_path)
    end
end



local filepath_ricordi = vim.fn.stdpath('config') .. "/tasks.txt"
local filepath_appunti = vim.fn.stdpath('config') .. "/notes.txt"

function Ricordi()
    checkfile(filepath_ricordi)
    open_file_in_split(filepath_ricordi)
end
function Appunti()
    checkfile(filepath_appunti)
    open_file_in_split(filepath_appunti)
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader><leader>t', ':lua Ricordi()<CR>', opts)
vim.keymap.set('n', '<leader><leader>n', ':lua Appunti()<CR>', opts)
