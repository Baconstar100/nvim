require('trouble').setup {
	opts = {},
	cmd = "Trouble"
}

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>");

