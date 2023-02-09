vim.g.mapleader = " "

vim.keymap.set("n", " ", "<nop>", { noremap = true })
vim.keymap.set("n", "<leader>pe", vim.cmd.Ex)
vim.keymap.set("n", "<C-9>", "<C-w>h")
vim.keymap.set("n", "<C-0>", "<C-w>l")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "<nop>")
vim.keymap.set("n", "<C-z>", "<nop>", { noremap = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search is allways on center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever, paste to void
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>f", ":Format<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":wa<cr>:Format<cr>", { noremap = true, silent = true })
