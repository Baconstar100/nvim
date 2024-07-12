function ColorThing(color)
	color = color or 'fluoromachine'
	vim.cmd.colorscheme(color)
	vim.cmd("syntax on")
end

ColorThing()
