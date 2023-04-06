local status, lualine = pcall(require, 'lualine')
if not status then
  return
end
local p = {
  ---@deprecated for backwards compatibility
  _experimental_nc = '#1f1d30',
  nc = '#1f1d30',
  base = '#232136',
  surface = '#2a273f',
  overlay = '#393552',
  muted = '#6e6a86',
  subtle = '#908caa',
  text = '#e0def4',
  love = '#eb6f92',
  gold = '#f6c177',
  rose = '#ea9a97',
  pine = '#3e8fb0',
  foam = '#9ccfd8',
  iris = '#c4a7e7',
  highlight_low = '#2a283e',
  highlight_med = '#44415a',
  highlight_high = '#56526e',
  none = 'NONE',
}

-- local p = require('rose-pine.palette')
local rosePineTheme = {
	normal = {
		a = { bg = p.rose, fg = p.base, gui = 'bold' },
		b = { bg = p.overlay, fg = p.rose },
		c = { bg = p.base, fg = p.text },
	},
	insert = {
		a = { bg = p.foam, fg = p.base, gui = 'bold' },
		b = { bg = p.overlay, fg = p.foam },
		c = { bg = p.base, fg = p.text },
	},
	visual = {
		a = { bg = p.iris, fg = p.base, gui = 'bold' },
		b = { bg = p.overlay, fg = p.iris },
		c = { bg = p.base, fg = p.text },
	},
	replace = {
		a = { bg = p.pine, fg = p.base, gui = 'bold' },
		b = { bg = p.overlay, fg = p.pine },
		c = { bg = p.base, fg = p.text },
	},
	command = {
		a = { bg = p.love, fg = p.base, gui = 'bold' },
		b = { bg = p.overlay, fg = p.love },
		c = { bg = p.base, fg = p.text },
	},
	inactive = {
		a = { bg = p.base, fg = p.muted, gui = 'bold' },
		b = { bg = p.base, fg = p.muted },
		c = { bg = p.base, fg = p.muted },
	},
}

lualine.setup({
  options = {
    theme = rosePineTheme
  }
})
