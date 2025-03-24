local dataDir = vim.fn.has('nvim') == 1 and vim.fn.stdpath('data') .. '/site'

if vim.fn.empty(vim.fn.glob(dataDir .. '/autoload/plug.vim')) > 0 then
	vim.fn.system({
		'curl', '-fLo', dataDir .. '/autoload/plug.vim', '--create-dirs',
		'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	})
end

require('remap')

local Plug = vim.fn['plug#']

vim.call("plug#begin")

Plug('https://github.com/rktjmp/lush.nvim.git')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
Plug('nvim-treesitter/playground')
Plug('theprimeagen/harpoon', {branch = "harpoon2"} )
Plug('mbbill/undotree')
Plug('tpope/vim-fugitive')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('sudormrfbin/cheatsheet.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-lua/plenary.nvim')

-- Color Scheme
Plug('samharju/synthweave.nvim')
Plug('rafi/awesome-vim-colorschemes')
Plug('maxmx03/fluoromachine.nvim')

-- LSP
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('VonHeikemen/lsp-zero.nvim', {branch = 'v3.x'})
Plug('jlcrochet/vim-razor')

vim.call("plug#end")
