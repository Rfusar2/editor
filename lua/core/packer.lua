vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.8' }
  -- use ('nvim-treesitter/nvim-treesitter', {run = ":TSUpdate"})
  
  use 'nvim-tree/nvim-web-devicons'
  use ('nvim-tree/nvim-tree.lua', {run = ':TSUpdate'})
  use 'rcarriga/nvim-notify'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Lettore File CSV
  use 'akinsho/toggleterm.nvim'
  use 'theKnightsOfRohan/csvlens.nvim'


  --use 'opilotC-Nvim/CopilotChat.nvim'

  --use {
  --  "kndndrj/nvim-dbee",
  --  requires = {
  --    "MunifTanjim/nui.nvim",
  --  },
  --  run = function()
  --    -- Install tries to automatically detect the install method.
  --    -- if it fails, try calling it with one of these parameters:
  --    --    "curl", "wget", "bitsadmin", "go"
  --    require("dbee").install()
  --  end,
  --  config = function()
  --    require("dbee").setup(--[[optional config]])
  --  end
  --}
  

  --Lettore File MD
  use({ "iamcco/markdown-preview.nvim", 
    run = "cd app && npm install", 
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, 
  })

  --Debugger
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} } 

  -- Plugin per LSP (Language Server Protocol)
  use 'neovim/nvim-lspconfig'    

  use({
  	"L3MON4D3/LuaSnip",
  	-- follow latest release.
  	tag = "v2.4.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  	run = "make install_jsregexp"
  })

  use "mason-org/mason-lspconfig.nvim"
  use "mason-org/mason.nvim"

  -- Plugin per nvim-cmp e le sue fonti
  use 'hrsh7th/nvim-cmp'         -- Il motore di completamento principale
  use 'hrsh7th/cmp-nvim-lsp'     -- Fonte di completamento per LSP
  use 'hrsh7th/cmp-buffer'       -- Fonte di completamento per il buffer
  use 'hrsh7th/cmp-path'         -- Fonte di completamento per i percorsi
  use 'hrsh7th/cmp-cmdline'      -- Fonte di completamento per la cmdline

  -- Per utenti vsnip
  use 'hrsh7th/cmp-vsnip'        -- Integrazione con vsnip
  use 'hrsh7th/vim-vsnip'        -- Motore di snippet

end)
