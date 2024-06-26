require('remap')

local Plug = vim.fn['plug#']

vim.call("plug#begin")

Plug('https://github.com/rktjmp/lush.nvim.git')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.4'})
Plug('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
Plug('nvim-treesitter/playground')
Plug('theprimeagen/harpoon', {branch = "harpoon2"} )
Plug('mbbill/undotree')
Plug('tpope/vim-fugitive')

-- Color Scheme
Plug('samharju/synthweave.nvim')
Plug('rafi/awesome-vim-colorschemes')

-- LSP
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('VonHeikemen/lsp-zero.nvim', {branch = 'v3.x'})


vim.call("plug#end")
