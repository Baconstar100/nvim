function ColorThing(color)
	color = color or 'moonfly'
	vim.cmd.colorscheme(color)
	vim.cmd("syntax on")
end

ColorThing()
