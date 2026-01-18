# My Editor Config (NVIM)

![MyBadge](https://img.shields.io/badge/Version-0.6.30-purple)
![MyBadge](https://img.shields.io/badge/NewFeatures-3-blue)

### Features

- [x]  [Chess Docs](lua\core\plugin\telescope\docs\scacchi\README.md)
- [x]  [Some shortcut](lua/core/help.lua)
- [x]  Lsp Server Python, [here](lua/core/lsp_server/pyright.lua)

### New Features

- [ ] Wrapper for debugger, [here](lua/core/debugger/init.lua)
- [ ] Plug-in for handling protocols SMTP/IMAP [tool email](lua/core/plugin/email/README.md) 

<details>
    <summary>Consts of a correct configuration (CUSTOM MENU)</summary>

    SNIPPETS_CONST:         "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/snippets/libs"
    SNIPPETS_CONFIG:        "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/snippets/menu.lua"
    
    CUSTOM_MENU_CONFIG:     "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/init.lua"
    
    DOCS_CONST:             "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/docs/const.lua"
    DOCS_CONFIG:            "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/docs/menu.lua"
    
    SET_FUNC_REG_CONST:     "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/scripts/lib"
    SET_FUNC_REG_CONFIG:    "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/scripts/menu.lua"
    
    TASKS_EDIT:             "C:/Users/Utente/AppData/Local/nvim/lua/core/ricordi/ricordi.md"

</details>

## Extra Notes

to download the necessary dependencies do `:lua setup_environment()`

fonts that allow you to view web icons [font Hack](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Medium/FiraMonoNerdFontMono-Medium.otf)

reading the vim/nvim document [VIM docs](https://youtu.be/rT-fbLFOCy0?si=R5yYmHxDoNBdzHOa)
    
    refresh cache -> sudo fc-cahce -f -v

to get information when writing code, you need to have `node` and the following packages available globally.
In case you want to have javascript/typescript and python available
    
    javascript/typescript -> npm install typescript-language-server
    python -> npm install copyright-langserver 

to use the CSV reader [repository](https://github.com/YS-L/csvlens) </summary>
something may be wrong, try starting administrator nvim to see if it fixes
```lua
-- WINDOWS
winget install --id YS-L.csvlens
```    
for debugger
    `pip install debugpy`

to use live_grep with telescopes

```lua
-- WINDOWS
choco install ripgrep
```    

for updating nvim use
```lua
-- WINDOWS
choco upgrade nvim
```    
