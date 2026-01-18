local M = {}

local home = my_global_vars.home .. "/lua/core/plugin/telescope/snippets/libs"

M.snippets = {
   ["Golang - Server Init"] = home .. "/go_Server1.go",
   ["Golang - Server Utils"] = home .. "/go_Server2.go",
   ["Python - Connect Imap"] = home .. "/py_Imap.py",
}
return M
