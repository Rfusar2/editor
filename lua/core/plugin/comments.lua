-- Definizione degli highlight
vim.api.nvim_set_hl(0, "CommentRed",    { fg = "#FF5555", bg = "#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentBlue",   { fg = "#52CBFF", bg = "#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentGreen",  { fg = "#55FF55", bg = "#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentTODO",   { fg = "#EAB810", bg = "#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentViolet", { fg = "#EE33FF", bg = "#000000", bold = true, italic = true })

--!        test comment
--[!!!]    test comment
--TODO     test comment
--.        test comment
--*        test comment
--[DOC]    test comment
--?        test comment
--[???]    test comment

-- Namespace per evidenziazione
local ns = vim.api.nvim_create_namespace("custom_comments")

-- Pattern per linguaggi
local minus = {
  danger   = { "%-%-!.*", "%-%-%[!!!%].*"},
  question = { "%-%-%?.*", "%-%-%[%?%?%?%].*" },
  todo     = { "%-%-TODO.*" },
  comment  = { "%-%-%[DOC%].*", "%-%-%*.*" },
  violet   = { "%-%-%..*" },
}

local hash = {
  danger   = { "#!.*", "#%[!!!%].*"},
  question = { "#%?.*", "#%[%?%?%?%].*" },
  todo     = { "#TODO.*" },
  comment  = { "#%[DOC%].*", "#%*.*" },
  violet   = { "#%..*" },
}

local slash = {
  danger   = { "//!.*", "//%[!!!%].*"},
  question = { "//%?.*", "//%[%?%?%?%].*" },
  todo     = { "//TODO.*" },
  comment  = { "//%[DOC%].*", "//%*.*" },
  violet   = { "//%..*" },
}

local apos = {
  danger   = { "'!.*", "'%[!!!%].*"},
  question = { "'%?.*", "'%[%?%?%?%].*" },
  todo     = { "'TODO.*" },
  comment  = { "'%[DOC%].*", "'%*.*" },
  violet   = { "'%..*" },
}

-- Mappatura filetype -> pattern
local patterns = {
  lua        = minus,
  python     = hash,
  powershell = hash,
  javascript = slash,
  typescript = slash,
  c          = slash,
  cs         = slash,
  cpp        = slash,
  vb         = apos,
}

-- Controlla se una riga matcha con almeno un pattern
local function matches_any(line, pattern_list)
  for _, pat in ipairs(pattern_list) do
    if line:match(pat) then return true end
  end
  return false
end

-- Funzione principale per evidenziare
local function highlight(bufnr, filetype)
  if not patterns[filetype] or not vim.api.nvim_buf_is_valid(bufnr) then return end

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local pat = patterns[filetype]

  for i, line in ipairs(lines) do
    local len = #line
    if matches_any(line, pat.danger) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentRed", i - 1, 0, len)
    elseif matches_any(line, pat.question) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentBlue", i - 1, 0, len)
    elseif matches_any(line, pat.todo) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentTODO", i - 1, 0, len)
    elseif matches_any(line, pat.violet) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentViolet", i - 1, 0, len)
    elseif matches_any(line, pat.comment) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentGreen", i - 1, 0, len)
    end
  end
end

-- Autocomando per triggerare l'highlight
vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufWritePost",
  "TextChanged",
  "TextChangedI",
  "FileType"
}, {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if patterns[ft] then
      highlight(args.buf, ft)
    end
  end,
})
