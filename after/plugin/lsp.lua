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
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(win).relative ~= '' then
				vim.api.nvim_win_close(win, true)
			end
		end
	end
})

require('mason').setup({})
require('mason-lspconfig').setup({
	-- PACKAGE REQUREMENTS
	-- clangd: unzip
	-- bashls: npm
	ensure_installed = {'lua_ls', 'clangd', 'bashls', 'omnisharp'},
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
