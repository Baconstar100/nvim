local lsp = require('lsp-zero')
local cmp = require('cmp')
local diagnostic_win = nil
local hover_win = nil


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

function showFloat()
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			local bufnr = 0
			local cursorPos = vim.api.nvim_win_get_cursor(0)
			local line = cursorPos[1] - 1
			local col = cursorPos[2]

			local diagnostics = vim.diagnostic.get(0, {lnum = line})
			local diagLines = {}

			for _, d in ipairs(diagnostics) do
				if d.col <= col and col < d.end_col then
					if d.severity == vim.diagnostic.severity.ERROR then
						table.insert(diagLines, "🔴 **Error**: " .. d.message)
					elseif d.severity == vim.diagnostic.severity.WARN then
						table.insert(diagLines, "🟡 **Warning**: " .. d.message)
					end
				end
			end

			vim.lsp.buf_request(bufnr, "textDocument/hover", vim.lsp.util.make_position_params(), function(err, result)
				if err or not result or not result.contents then return end

				local raw = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
				local joined = table.concat(raw, "\n")
				local hoverLines = vim.split(joined, "\n", {trimempty = true})

				local combinedLines = {}
				if #hoverLines > 0 then
					vim.list_extend(combinedLines, hoverLines)
				end
				if #diagLines > 0 then
					table.insert(combinedLines, "")
					vim.list_extend(combinedLines, diagLines)
				end

				if #combinedLines == 0 then return end

				vim.lsp.util.open_floating_preview(combinedLines, "markdown", {
					border = "rounded",
					focusable = false,
				})
			end)
		end
	})
end


vim.api.nvim_create_autocmd("CursorMoved", {
  	callback = function()
    		if diagnostic_win and vim.api.nvim_win_is_valid(diagnostic_win) then
      			vim.api.nvim_win_close(diagnostic_win, true)
      			diagnostic_win = nil
		end

		if hover_win and vim.api.nvim_win_is_valid(hover_win) then
      			vim.api.nvim_win_close(hover_win, true)
      			hover_win = nil
		end
  	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
		if buftype ~= "" then
			if diagnostic_win and vim.api.nvim_win_is_valid(diagnostic_win) then
				vim.api.nvim_win_close(diagnostic_win, true)
				diagnostic_win = nil
			end

			if hover_win and vim.api.nvim_win_is_valid(hover_win) then
				vim.api.nvim_win_close(hover_win, true)
				hover_win = nil
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


showFloat()
