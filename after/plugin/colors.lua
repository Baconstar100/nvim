function ColorThing(color)
	color = color or 'gotham256'
	vim.cmd.colorscheme(color)
	vim.cmd("syntax on")
end

ColorThing()
