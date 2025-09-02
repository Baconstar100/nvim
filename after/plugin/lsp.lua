local lsp = require('lsp-zero')
local cmp = require('cmp')
local hover_win_open = true

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
		virtual_text = true,
	}
)

function is_hover_supported(bufnr)
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
    if client.supports_method("textDocument/hover") then
      return true
    end
  end
  return false
end

function showFloat()
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line = cursor[1] - 1
      local col = cursor[2]

      if not is_hover_supported(bufnr) then return end

      -- Filter diagnostics by exact column match
      local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
      local diag_lines = {}

      for _, d in ipairs(diagnostics) do
        local start_col = d.col
        local end_col = d.end_col or (start_col + 1) -- fallback if end_col is missing

        if col >= start_col and col < end_col then
          if d.severity == vim.diagnostic.severity.ERROR then
            table.insert(diag_lines, "🔴 **Error**: " .. d.message)
          elseif d.severity == vim.diagnostic.severity.WARN then
            table.insert(diag_lines, "🟠 **Warning**: " .. d.message)
          end
        end
      end

      -- Request hover info
      vim.lsp.buf_request(bufnr, "textDocument/hover", vim.lsp.util.make_position_params(), function(err, result)
        if err or not result or not result.contents then return end

        local hover_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        hover_lines = vim.lsp.util.trim_empty_lines(hover_lines)

        -- Combine hover and diagnostics
        local combined_lines = {}

        if #hover_lines > 0 then
          vim.list_extend(combined_lines, hover_lines)
        end

        if #diag_lines > 0 then
          table.insert(combined_lines, "") -- spacing
          vim.list_extend(combined_lines, diag_lines)
        end

        if #combined_lines == 0 then return end

        hover_win_open = false
	vim.lsp.util.open_floating_preview(combined_lines, "markdown", {
          border = "rounded",
          focusable = false,
        })
      end)
    end
  })
end


lsp.preset('recommended')
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

lsp.setup()
vim.o.updatetime = 250
showFloat()
