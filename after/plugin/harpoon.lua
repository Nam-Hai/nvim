local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<C-a>", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-5>", function() ui.nav_file(5) end, { noremap = true, silent = true })


vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
