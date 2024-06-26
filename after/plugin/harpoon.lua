local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-r>", function() harpoon:list():remove() end)
vim.keymap.set("n", "<C- >", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i = 1, 9 do
	vim.keymap.set("n", "<A-" .. tostring(i) .. ">", function() harpoon:list():select(i) end);
	vim.keymap.set("n", "<C-A-r>" .. tostring(i), function() harpoon:list():remove_at(i) end);
	vim.keymap.set("n", "<C-A-s>" .. tostring(i), function() harpoon:list():replace_at(i) end);
end

vim.keymap.set("n", "<A-Left>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<A-Right>", function() harpoon:list():next() end)
