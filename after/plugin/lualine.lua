vim.opt.showmode = false;
vim.opt.showmatch = false;

local function lineLocation()
	return vim.fn.line('.') .. ':' .. vim.fn.charcol('.') .. ' / ' .. vim.fn.line('$') .. ':' .. vim.fn.charcol('$')
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
    		lualine_z = {lineLocation}
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
