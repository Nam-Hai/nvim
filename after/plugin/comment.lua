local comment = require("Comment")
comment.setup({
	toggler = {
		---Line-comment keymap
		line = "<M-a>",
		---Block-comment keymap
	},
	opleader = {
		---Line-comment keymap
		line = "<M-a>",
		---Block-comment keymap
	},
	mapping = {
		extra = false,
	},
})

-- comment.keymap.set("n", "gcc", "<C-a>")
