local function save_buffer_with_same_extension()
    local file_path = vim.api.nvim_buf_get_name(0)
    if file_path == "" then
        print("Buffer non associato a nessun file")
        return
    end

    local ext = file_path:match("^.+(%..+)$") or ""

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, "\n")

    local temp_file = my_global_vars.home .. "/lua/core/plugin/formatter/INPUT" .. ext
    local f = io.open(temp_file, "w")
    if f then
        f:write(content)
        f:close()
    else
        print("Errore scrivendo su: " .. temp_file)
        return
    end

    vim.cmd("!python ".. my_global_vars..home .."/lua/core/plugin/formatter/main.py " .. file_path .. " " .. temp_file)

    return file_path, temp_file
end

vim.api.nvim_create_user_command("Formatter", function(opts)
    local original_file, saved_file = save_buffer_with_same_extension()
end, {nargs = "*"})
