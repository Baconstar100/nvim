local lsp = require('lsp-zero')
local cmp = require('cmp')
local diagnostic_float_win = nil


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
--vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    if diagnostic_float_win == nil or not vim.api.nvim_win_is_valid(diagnostic_float_win) then
      diagnostic_float_win = vim.diagnostic.open_float(nil, {
        focusable = false,
        scope = "cursor"
      })
    end
  end
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
print(diagnostic_float_win)
    if diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then
      vim.api.nvim_win_close(diagnostic_float_win, true)
      diagnostic_float_win = nil
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
