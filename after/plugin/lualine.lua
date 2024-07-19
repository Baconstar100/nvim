vim.opt.showmode = false;
vim.opt.showmatch = false;

local function fileInHarpoon()
	local h = require('harpoon')
	local x = vim.cmd('file')
	local path = string.sub(x, string.find(x, '"')+1, string.find(x, '"', 2)-1)
	return h:list():get_by_value(path).idx;
end


require('lualine').setup {
	options = {
    		component_separators = { left = '', right = ''},
    		section_separators = { left = '', right = ''},
  	},
  	sections = {
    		lualine_a = {'mode'},
    		lualine_b = {'branch', 'diff', 'diagnostics'},
    		lualine_c = {{'filename', path = 4}, {'filetype', icon_only = true} },
    		lualine_x = {'searchcount'},
		lualine_y = {},
    		lualine_z = {'location'}
  	},
  	inactive_sections = {
    		lualine_a = {{'filename', path = 4}, {'filetype', icon_only = true} },
    		lualine_b = {},
    		lualine_c = {},
    		lualine_x = {},
    		lualine_y = {},
    		lualine_z = {}
  	},
}

