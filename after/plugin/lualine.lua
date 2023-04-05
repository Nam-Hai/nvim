local status, lualine = pcall(require, 'lualine')
if not status then
  return
end

local p = require('rose-pine.palette')
local m = require('monokai').ristretto
local rosePineTheme = {
	normal = {
		a = { bg = p.rose, fg = p.base, gui = 'bold' },
		b = { bg = m.brown, fg = p.rose },
		c = { bg = m.base2, fg = p.text },
	},
	insert = {
		a = { bg = m.aqua, fg = p.base, gui = 'bold' },
		b = { bg = m.brown, fg = m.aqua },
		c = { bg = m.base2, fg = p.text },
	},
	visual = {
		a = { bg = p.iris, fg = p.base, gui = 'bold' },
		b = { bg = m.brown, fg = p.iris },
		c = { bg = m.base2, fg = p.text },
	},
	replace = {
		a = { bg = p.pine, fg = p.base, gui = 'bold' },
		b = { bg = m.brown, fg = p.pine },
		c = { bg = m.base2, fg = p.text },
	},
	command = {
		a = { bg = m.pink, fg = p.base, gui = 'bold' },
		b = { bg = m.brown, fg = m.pink },
		c = { bg = m.base2, fg = p.text },
	},
	inactive = {
		a = { bg = p.base, fg = p.muted, gui = 'bold' },
		b = { bg = m.brown, fg = p.muted },
		c = { bg = m.base2, fg = p.muted },
	},
}

lualine.setup({
  options = {
    theme = rosePineTheme
  }
})
