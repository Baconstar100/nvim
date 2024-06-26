--[[
require('galaxyline').section.left[1] = {
	FileSize = {
		provider = 'FileSize',
		condition = function()
			if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
				return true
			end
			return false
		end,
		icon = ' eggs ',
		hightlight = {colors.green, colors.purple},
		separator = 'gg',
		separator_highlight = {colors.purple, colors.darkblue},
	},
}
]]
