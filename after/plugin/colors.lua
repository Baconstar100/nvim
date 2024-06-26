function ColorThing(color)
	color = color or 'synthweave'
	vim.cmd.colorscheme(color)
	vim.cmd("syntax on")
end

ColorThing()
