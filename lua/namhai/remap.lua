vim.g.mapleader = " "

vim.keymap.set("n", "<C-c>", "<C-c>:noh<CR>")
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

-- yank to clip
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- vim.keymap.set("n", "<leader>f", ":Format<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":wa<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-s>", ":wa<cr>:Format<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>f", "lua vim.lsp.buf.format()", { noremap = true })
  

-- vim.keymap.set("i", "(", "()<left>", {noremap = true})
-- vim.keymap.set("i", "[", "[]<left>", {noremap = true})
-- vim.keymap.set("i", "{", "{}<left>", {noremap = true})

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>z", ":ZenMode<CR>")
