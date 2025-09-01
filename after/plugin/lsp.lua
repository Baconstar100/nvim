local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
		virtual_text = true,
	}
)

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

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


--cmp.setup({
--	preselct = 'item',
--	completion = {
--		completeopt = 'menu,menuone,noinsert'
--	},
--	mapping = {
--		['<CR>'] = cmp.mapping.confirm({select = true}),
--	},
--	window = {
--		completion = cmp.config.window.bordered(),
--		documentation = cmp.config.window.bordered(),
--	},
--})
