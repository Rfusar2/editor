local M = {}

local home = "C:/Users/nemes/Desktop/WORK"

if _G.my_global_vars.isWindows == true then
    M.projects = {
        ["Lessons"] = "C:/Users//Desktop/Lessons",
        
        ["Update Nvim"] = "C:/Users/nemes/AppData/Local/nvim",
        ["Update Nvim-Data"] = "C:/Users/nemes/AppData/Local/nvim-data",
        
        ["WORK - Variables"] = "C:/Users/nemes/Desktop/VARS",
        ["WORK - DoValue - Document Generator"] = home .. "/DOVALUE",
        ["WORK - Fasdac - KTA"] = home .. "/FASDAC",
        ["WORK - PRELIOS - KTA"] = home .. "/PRELIOS",
        ["API  - zoho-odoo"] = home .. "/NEMESIS/zoho-odoo",

        ["FUNC - Add New Path"] = "",
        ["FUNC - Add New Snippet"] = "",
        ["FUNC - Add New Script"] = "",
    }


else
    M.projects = {
        ["LIB - nvim"] = "/home/riccardo/.config/nvim",
        ["My Libraries"] = "/home/riccardo/Scrivania/MyLib",
        ["SYS - Copy Current Directory"] = "",
        ["FUNC - Add New Path"] = "",
        ["FUNC - Add New Snippet"] = "",
        ["FUNC - Add New Script"] = "",
        ["FUNC - Copy Current Directory"] = "",
    }
end


return M
