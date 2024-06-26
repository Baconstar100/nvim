local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	-- PACKAGE REQUREMENTS
	-- clangd: unzip
	-- bashls: npm
	ensure_installed = {'lua_ls', 'clangd', 'bashls'},
	handlers = {
		lsp.default_setup,
	},
})


cmp.setup({
	preselct = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = true}),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})
