local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
vim.keymap.set("n", "<C- >", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i = 1, 9 do
	vim.keymap.set("n", "<A-" .. tostring(i) .. ">", function() harpoon:list():select(i) end);
end

vim.keymap.set("n", "<C-s>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-d>", function() harpoon:list():next() end)
