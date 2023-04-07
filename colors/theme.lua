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

local rosewood = '#F45B69'
local amaranth = '#db324d'
local auburn = '#a62639'

vim.cmd('hi clear')
vim.opt.termguicolors = true
-- vim.g.colors_name = 'rose-pine'

-- vim.cmd('highlight clear')

-- local p = {
--   _experimental_nc = '#f8f0e7',
--   nc = '#f8f0e7',
--   base = '#faf4ed',
--   surface = '#fffaf3',
--   overlay = '#f2e9e1',
--   muted = '#9893a5',
--   subtle = '#797593',
--   text = '#575279',
--   love = '#b4637a',
--   gold = '#ea9d34',
--   rose = '#d7827e',
--   pine = '#286983',
--   foam = '#56949f',
--   iris = '#907aa9',
--   highlight_low = '#f4ede8',
--   highlight_med = '#dfdad9',
--   highlight_high = '#cecacd',
--   none = 'NONE',
-- }

local function byte(value, offset)
  return bit.band(bit.rshift(value, offset), 0xFF)
end

local function rgb(color)
  if color == -1 then
    color = vim.opt.background:get() == 'dark' and '000' or '255255255'
  else
    color = vim.api.nvim_get_color_by_name(color)
  end

  return { byte(color, 16), byte(color, 8), byte(color, 0) }
end

local function parse_color(c)
  if c == nil then
    return print('invalid color')
  end
  local color = tostring(c)

  color = color:lower()
  color = color == "-1" and 'none' or color

  if not color:find('#') and color ~= 'none' then
    color = p.color
        or vim.api.nvim_get_color_by_name(color)
  end

  return color
end

local function blend(fg, bg, alpha)
  local fg_rgb = rgb(parse_color(fg))
  local bg_rgb = rgb(parse_color(bg))

  local function blend_channel(i)
    local ret = (alpha * fg_rgb[i] + ((1 - alpha) * bg_rgb[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format(
    '#%02X%02X%02X',
    blend_channel(1),
    blend_channel(2),
    blend_channel(3)
  )
end


local highlight = function(group, color)
  local fg = color.fg and parse_color(color.fg) or 'none'
  local bg = color.bg and parse_color(color.bg) or 'none'
  local sp = color.sp and parse_color(color.sp) or ''
  if
      color.blend ~= nil
      and (color.blend >= 0 or color.blend <= 100)
      and bg ~= nil
  then
    bg = blend(bg, parse_color('base') or '', color.blend / 100)
  end

  color = vim.tbl_extend('force', color, { fg = fg, bg = bg, sp = sp })
  vim.api.nvim_set_hl(0, group, color)
end

local h = function(group, background, fontColor, style)
  -- local fg = color.fg and parse_color(color.fg) or 'none'
  -- local bg = color.bg and parse_color(color.bg) or 'none'
  -- local sp = color.sp and parse_color(color.sp) or ''
  local gui = style == '' and '' or 'gui=' .. style;
  local fg = fontColor == '' and '' or 'guifg=' .. fontColor;
  local bg = background == '' and '' or 'guibg=' .. background;
  vim.cmd("hi " .. group .. ' ' .. bg .. ' ' .. fg .. ' ' .. gui);
end


-- local highlight = require('rose-pine.util').highlight
-- local p = require('rose-pine.palette')

local options = {
  variant = 'auto',
  dark_variant = 'main',
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = false,
  disable_float_background = false,
  disable_italics = false,
  groups = {
    background = p.base,
    background_nc = p.nc,
    panel = p.surface,
    panel_nc = p.base,
    border = p.highlight_med,
    comment = p.muted,
    link = p.iris,
    punctuation = p.muted,
    error = p.love,
    hint = p.iris,
    info = p.foam,
    warn = p.gold,
    git_add = p.foam,
    git_change = p.rose,
    git_delete = p.love,
    git_dirty = p.rose,
    git_ignore = p.muted,
    git_merge = p.iris,
    git_rename = p.pine,
    git_stage = p.iris,
    git_text = p.rose,
    headings = {
      h1 = p.iris,
      h2 = p.foam,
      h3 = p.rose,
      h4 = p.gold,
      h5 = p.pine,
      h6 = p.foam,
    },
  },
  highlight_groups = {},
}

vim.opt.termguicolors = true
vim.tbl_deep_extend('force', {}, options, options)

local groups = options.groups or {}

local maybe = {
  base = (options.disable_background and p.foam) or groups.background,
  surface = (options.disable_float_background and p.foam) or groups.panel,
  italic = not options.disable_italics,
}
maybe.bold_vert_split = (options.bold_vert_split and groups.border)
    or p.none
maybe.dim_nc_background = (
    options.dim_nc_background and groups.background_nc
    ) or maybe.base


highlight('ColorColumn', { bg = p.overlay })
-- h('TermCursor', p.overlay, '', '')
highlight('Conceal', { bg = p.none })

-- highlight('Search', { bg = p.highlight_med })
-- highlight('Search', { fg = groups.background, bg = p.rose })
-- highlight('IncSearch', { fg = p.text, bg = auburn })

highlight('Search', { fg = p.base, bg = p.rose })
highlight('IncSearch', { fg = "#ff0000", bg = '#000000' })

highlight('CurSearch', { link = 'IncSearch' })
highlight('Cursor', { fg = p.text, bg = p.highlight_high })
highlight('CursorColumn', { bg = p.highlight_low })
-- CursorIM = {},
highlight('CursorLine', { bg = p.highlight_low })
highlight('CursorLineNr', { fg = p.text })
highlight('DarkenedPanel', { bg = maybe.surface })
highlight('DarkenedStatusline', { bg = maybe.surface })
highlight('DiffAdd', { bg = groups.git_add })

highlight('DiffChange', { bg = p.overlay })
highlight('DiffDelete', { bg = groups.git_delete })
-- highlight('DiffDelete', { bg = p.love})
highlight('DiffText', { bg = groups.git_text })
highlight('diffAdded', { link = 'DiffAdd' })
highlight('diffChanged', { link = 'DiffChange' })
highlight('diffRemoved', { link = 'DiffDelete' })
highlight('Directory', { fg = p.foam, bg = p.none })
-- EndOfBuffer = {},
highlight('ErrorMsg', { fg = p.love, bold = true })
highlight('FloatBorder', { fg = groups.border, bg = maybe.surface })
highlight('FloatTitle', { fg = p.muted })
highlight('FoldColumn', { fg = p.muted })
highlight('Folded', { fg = p.text, bg = maybe.surface })
highlight('LineNr', { fg = p.muted })
highlight('MatchParen', { fg = p.text, bg = p.highlight_med })
highlight('ModeMsg', { fg = p.subtle })
highlight('MoreMsg', { fg = p.iris })
highlight('NonText', { fg = p.muted })
highlight('Normal', { fg = p.text, bg = maybe.base })
highlight('NormalFloat', { fg = p.text, bg = maybe.surface })
highlight('NormalNC', { fg = p.text, bg = maybe.dim_nc_background })
highlight('NvimInternalError', { fg = '#ffffff', bg = p.love })
highlight('Pmenu', { fg = p.subtle, bg = maybe.surface })
highlight('PmenuSbar', { bg = p.highlight_low })
highlight('PmenuSel', { fg = p.text, bg = p.overlay })
highlight('PmenuThumb', { bg = p.highlight_med })
highlight('Question', { fg = p.gold })
-- QuickFixLine = {},
-- RedrawDebugNormal = {}
highlight('RedrawDebugClear', { fg = '#ffffff', bg = p.gold })
highlight('RedrawDebugComposed', { fg = '#ffffff', bg = p.pine })
highlight('RedrawDebugRecompose', { fg = '#ffffff', bg = p.love })
highlight('SpecialKey', { fg = p.foam })
highlight('SpellBad', { sp = p.subtle, undercurl = true })
highlight('SpellCap', { sp = p.subtle, undercurl = true })
highlight('SpellLocal', { sp = p.subtle, undercurl = true })
highlight('SpellRare', { sp = p.subtle, undercurl = true })
highlight('SignColumn', {
  fg = p.text,
  bg = (options.dim_nc_background and p.none) or maybe.base,
})
highlight('StatusLine', { fg = p.subtle, bg = groups.panel })
highlight('StatusLineNC', { fg = p.muted, bg = groups.panel_nc })
highlight('StatusLineTerm', { link = 'StatusLine' })
highlight('StatusLineTermNC', { link = 'StatusLineNC' })
highlight('TabLine', { fg = p.subtle, bg = groups.panel })
highlight('TabLineFill', { bg = groups.panel })
highlight('TabLineSel', { fg = p.text, bg = p.overlay })
highlight('Title', { fg = p.text })
highlight('VertSplit', { fg = groups.border, bg = maybe.bold_vert_split })
highlight('Visual', { bg = p.highlight_med })
-- VisualNOS = {},
highlight('WarningMsg', { fg = p.gold })
-- Whitespace = {},
highlight('WildMenu', { link = 'IncSearch' })

highlight('Boolean', { fg = p.rose })
highlight('Character', { fg = p.gold })
highlight('Comment', { fg = groups.comment, italic = maybe.italic })
highlight('Conditional', { fg = p.pine })
highlight('Constant', { fg = p.gold })
highlight('Debug', { fg = p.rose })
highlight('Define', { fg = p.iris })
highlight('Delimiter', { fg = p.subtle })
highlight('Error', { fg = p.love })
highlight('Exception', { fg = p.pine })
highlight('Float', { fg = p.gold })
highlight('Function', { fg = p.rose })
highlight('Identifier', { fg = p.rose })
-- Ignore = {},
highlight('Include', { fg = p.iris })

-- highlight('Keyword', { fg = p.love })

highlight('Label', { fg = p.foam })
highlight('Macro', { fg = p.iris })
highlight('Number', { fg = p.gold })
highlight('Operator', { fg = p.subtle })
highlight('PreCondit', { fg = p.iris })
highlight('PreProc', { fg = p.iris })
highlight('Repeat', { fg = p.pine })
highlight('Special', { fg = p.rose })
highlight('SpecialChar', { fg = p.rose })
highlight('SpecialComment', { fg = p.iris })
highlight('Statement', { fg = p.pine })
highlight('StorageClass', { fg = p.foam })
highlight('String', { fg = p.gold })
highlight('Structure', { fg = p.foam })
highlight('Tag', { fg = p.rose })
highlight('Todo', { fg = p.iris })
highlight('Type', { fg = p.foam })
local typeOptions = { fg = p.foam }
highlight('Typedef', typeOptions)
highlight('Underlined', { underline = true })

highlight('htmlArg', { fg = p.iris })
highlight('htmlBold', { bold = true })
highlight('htmlEndTag', { fg = p.subtle })
highlight('htmlH1', { fg = groups.headings.h1, bold = true })
highlight('htmlH2', { fg = groups.headings.h2, bold = true })
highlight('htmlH3', { fg = groups.headings.h3, bold = true })
highlight('htmlH4', { fg = groups.headings.h4, bold = true })
highlight('htmlH5', { fg = groups.headings.h5, bold = true })
highlight('htmlItalic', { italic = maybe.italic })
highlight('htmlLink', { fg = groups.link })
highlight('htmlTag', { fg = p.subtle })
highlight('htmlTagN', { fg = p.text })
highlight('htmlTagName', { fg = p.foam })

highlight('markdownDelimiter', { fg = p.subtle })
highlight('markdownH1', { fg = groups.headings.h1, bold = true })
highlight('markdownH1Delimiter', { link = 'markdownH1' })
highlight('markdownH2', { fg = groups.headings.h2, bold = true })
highlight('markdownH2Delimiter', { link = 'markdownH2' })
highlight('markdownH3', { fg = groups.headings.h3, bold = true })
highlight('markdownH3Delimiter', { link = 'markdownH3' })
highlight('markdownH4', { fg = groups.headings.h4, bold = true })
highlight('markdownH4Delimiter', { link = 'markdownH4' })
highlight('markdownH5', { fg = groups.headings.h5, bold = true })
highlight('markdownH5Delimiter', { link = 'markdownH5' })
highlight('markdownH6', { fg = groups.headings.h6, bold = true })
highlight('markdownH6Delimiter', { link = 'markdownH6' })
highlight(
  'markdownLinkText',
  { fg = groups.link, sp = groups.link, underline = true }
)
highlight('markdownUrl', { link = 'markdownLinkText' })

highlight('mkdCode', { fg = p.foam, italic = maybe.italic })
highlight('mkdCodeDelimiter', { fg = p.rose })
highlight('mkdCodeEnd', { fg = p.foam })
highlight('mkdCodeStart', { fg = p.foam })
highlight('mkdFootnotes', { fg = p.foam })
highlight('mkdID', { fg = p.foam, underline = true })
highlight('mkdInlineURL', { fg = groups.link, underline = true })
highlight('mkdLink', { link = 'mkdInlineURL' })
highlight('mkdLinkDef', { link = 'mkdInlineURL' })
highlight('mkdListItemLine', { fg = p.text })
highlight('mkdRule', { fg = p.subtle })
highlight('mkdURL', { link = 'mkdInlineURL' })

highlight('DiagnosticError', { fg = groups.error })
highlight('DiagnosticHint', { fg = groups.hint })
highlight('DiagnosticInfo', { fg = groups.info })
highlight('DiagnosticWarn', { fg = groups.warn })
highlight('DiagnosticDefaultError', { fg = groups.error })
highlight('DiagnosticDefaultHint', { fg = groups.hint })
highlight('DiagnosticDefaultInfo', { fg = groups.info })
highlight('DiagnosticDefaultWarn', { fg = groups.warn })
highlight('DiagnosticFloatingError', { fg = groups.error })
highlight('DiagnosticFloatingHint', { fg = groups.hint })
highlight('DiagnosticFloatingInfo', { fg = groups.info })
highlight('DiagnosticFloatingWarn', { fg = groups.warn })
highlight('DiagnosticSignError', { fg = groups.error })
highlight('DiagnosticSignHint', { fg = groups.hint })
highlight('DiagnosticSignInfo', { fg = groups.info })
highlight('DiagnosticSignWarn', { fg = groups.warn })
highlight('DiagnosticStatusLineError', { fg = groups.error, bg = groups.panel })
highlight('DiagnosticStatusLineHint', { fg = groups.hint, bg = groups.panel })
highlight('DiagnosticStatusLineInfo', { fg = groups.info, bg = groups.panel })
highlight('DiagnosticStatusLineWarn', { fg = groups.warn, bg = groups.panel })
highlight('DiagnosticUnderlineError', { sp = groups.error, undercurl = true })
highlight('DiagnosticUnderlineHint', { sp = groups.hint, undercurl = true })
highlight('DiagnosticUnderlineInfo', { sp = groups.info, undercurl = true })
highlight('DiagnosticUnderlineWarn', { sp = groups.warn, undercurl = true })
highlight('DiagnosticVirtualTextError', { fg = groups.error })
highlight('DiagnosticVirtualTextHint', { fg = groups.hint })
highlight('DiagnosticVirtualTextInfo', { fg = groups.info })
highlight('DiagnosticVirtualTextWarn', { fg = groups.warn })

-- healthcheck
highlight('healthError', { fg = groups.error })
highlight('healthSuccess', { fg = groups.info })
highlight('healthWarning', { fg = groups.warn })

-- Treesitter
highlight('@boolean', { link = 'Boolean' })
highlight('@character', { link = 'Character' })
highlight('@character.special', { link = '@character' })
highlight('@class', { fg = p.foam })
highlight('@comment', { link = 'Comment' })
highlight('@conditional', { link = 'Conditional' })
highlight('@constant', { link = 'Constant' })
highlight('@constant.builtin', { fg = p.love })
highlight('@constant.macro', { link = '@constant' })
highlight('@constructor', { fg = p.foam })
highlight('@field', { fg = p.foam })
highlight('@function', { link = 'Function' })
highlight('@function.builtin', { fg = p.love })
highlight('@function.macro', { link = '@function' })
highlight('@include', { link = 'Include' })
highlight('@interface', { fg = p.foam })

vim.cmd("hi link Keyword NONE")

-- highlight('@keyword', { link = 'Keyword' })
highlight('@keyword.operator', { fg = p.subtle })
highlight('@label', { link = 'Label' })
highlight('@macro', { link = 'Macro' })
highlight('@method', { fg = p.iris })
highlight('@number', { link = 'Number' })
highlight('@operator', { link = 'Operator' })
highlight('@parameter', { fg = p.iris, italic = maybe.italic })
highlight('@preproc', { link = 'PreProc' })
highlight('@property', { fg = p.foam, italic = maybe.italic })
highlight('@punctuation', { fg = groups.punctuation })
highlight('@punctuation.bracket', { link = '@punctuation' })
highlight('@punctuation.delimiter', { link = '@punctuation' })
highlight('@punctuation.special', { link = '@punctuation' })
highlight('@regexp', { link = 'String' })
highlight('@repeat', { link = 'Repeat' })
highlight('@storageclass', { link = 'StorageClass' })
highlight('@string', { link = 'String' })
highlight('@string.escape', { fg = p.pine })
highlight('@string.special', { link = '@string' })
highlight('@symbol', { link = 'Identifier' })
highlight('@tag', { link = 'Tag' })
highlight('@tag.attribute', { fg = p.iris })
highlight('@tag.delimiter', { fg = p.subtle })
highlight('@text', { fg = p.text })
highlight('@text.strong', { bold = true })
highlight('@text.emphasis', { italic = true })
highlight('@text.underline', { underline = true })
highlight('@text.strike', { strikethrough = true })
highlight('@text.math', { link = 'Special' })
highlight('@text.environment', { link = 'Macro' })
highlight('@text.environment.name', typeOptions)
highlight('@text.title', { link = 'Title' })
highlight('@text.uri', { fg = groups.link })
highlight('@text.note', { link = 'SpecialComment' })
highlight('@text.warning', { fg = groups.warn })
highlight('@text.danger', { fg = groups.error })
highlight('@todo', { link = 'Todo' })
-- highlight('@type', { link = 'Type' })
highlight('@variable', { fg = p.text, italic = maybe.italic })
highlight('@variable.builtin', { fg = p.love })
highlight('@namespace', { link = '@include' })

-- LSP Semantic Token Groups
highlight('@lsp.type.enum', typeOptions)
highlight('@lsp.type.keyword', { link = '@keyword.operator' })
highlight('@lsp.type.interface', { link = '@interface' })
highlight('@lsp.type.namespace', { link = '@namespace' })
highlight('@lsp.type.parameter', { link = '@parameter' })
highlight('@lsp.type.property', { link = '@property' })
highlight('@lsp.type.variable', {}) -- use treesitter styles for regular variables
highlight('@lsp.typemod.function.defaultLibrary', { link = 'Special' })
highlight('@lsp.typemod.variable.defaultLibrary', { link = '@variable.builtin' })

-- LSP Injected Groups
highlight('@lsp.typemod.operator.injected', { link = '@operator' })
highlight('@lsp.typemod.string.injected', { link = '@string' })
highlight('@lsp.typemod.variable.injected', { link = '@variable' })

-- vim.lsp.buf.document_highlight()
highlight('LspReferenceText', { bg = p.highlight_med })
highlight('LspReferenceRead', { bg = p.highlight_med })
highlight('LspReferenceWrite', { bg = p.highlight_med })

-- lsp-highlight-codelens
highlight('LspCodeLens', { fg = p.subtle })                  -- virtual text of code len
highlight('LspCodeLensSeparator', { fg = p.highlight_high }) -- separator between two or more code len

-- romgrk/barbar.nvim
highlight('BufferCurrent', { fg = p.text, bg = p.overlay })
highlight('BufferCurrentIndex', { fg = p.text, bg = p.overlay })
highlight('BufferCurrentMod', { fg = p.foam, bg = p.overlay })
highlight('BufferCurrentSign', { fg = p.subtle, bg = p.overlay })
highlight('BufferCurrentTarget', { fg = p.gold, bg = p.overlay })
highlight('BufferInactive', { fg = p.subtle })
highlight('BufferInactiveIndex', { fg = p.subtle })
highlight('BufferInactiveMod', { fg = p.foam })
highlight('BufferInactiveSign', { fg = p.muted })
highlight('BufferInactiveTarget', { fg = p.gold })
highlight('BufferTabpageFill', { fg = groups.background, bg = groups.background })
highlight('BufferVisible', { fg = p.subtle })
highlight('BufferVisibleIndex', { fg = p.subtle })
highlight('BufferVisibleMod', { fg = p.foam })
highlight('BufferVisibleSign', { fg = p.muted })
highlight('BufferVisibleTarget', { fg = p.gold })

-- lewis6991/gitsigns.nvim
highlight('GitSignsAdd', { fg = groups.git_add, bg = groups.background })
highlight('GitSignsChange', { fg = groups.git_change, bg = groups.background })
highlight('GitSignsDelete', { fg = groups.git_delete, bg = groups.background })
highlight('SignAdd', { link = 'GitSignsAdd' })
highlight('SignChange', { link = 'GitSignsChange' })
highlight('SignDelete', { link = 'GitSignsDelete' })

-- mvllow/modes.nvim
highlight('ModesCopy', { bg = p.gold })
highlight('ModesDelete', { bg = p.love })
highlight('ModesInsert', { bg = p.foam })
highlight('ModesVisual', { bg = p.iris })

-- kyazdani42/nvim-tree.lua
highlight('NvimTreeEmptyFolderName', { fg = p.muted })
highlight('NvimTreeFileDeleted', { fg = p.love })
highlight('NvimTreeFileDirty', { fg = p.rose })
highlight('NvimTreeFileMerge', { fg = p.iris })
highlight('NvimTreeFileNew', { fg = p.foam })
highlight('NvimTreeFileRenamed', { fg = p.pine })
highlight('NvimTreeFileStaged', { fg = p.iris })
highlight('NvimTreeFolderIcon', { fg = p.subtle })
highlight('NvimTreeFolderName', { fg = p.foam })
highlight('NvimTreeGitDeleted', { fg = groups.git_delete })
highlight('NvimTreeGitDirty', { fg = groups.git_dirty })
highlight('NvimTreeGitIgnored', { fg = groups.git_ignore })
highlight('NvimTreeGitMerge', { fg = groups.git_merge })
highlight('NvimTreeGitNew', { fg = groups.git_add })
highlight('NvimTreeGitRenamed', { fg = groups.git_rename })
highlight('NvimTreeGitStaged', { fg = groups.git_stage })
highlight('NvimTreeImageFile', { fg = p.text })
highlight('NvimTreeNormal', { fg = p.text })
highlight('NvimTreeOpenedFile', { fg = p.text, bg = p.highlight_med })
highlight('NvimTreeOpenedFolderName', { link = 'NvimTreeFolderName' })
highlight('NvimTreeRootFolder', { fg = p.iris })
highlight('NvimTreeSpecialFile', { link = 'NvimTreeNormal' })
highlight('NvimTreeWindowPicker', { fg = p.love, bg = p.love, blend = 10 })

-- nvim-neo-tree/neo-tree.nvim
highlight('NeoTreeTitleBar', { fg = p.surface, bg = p.pine })

-- folke/which-key.nvim
highlight('WhichKey', { fg = p.iris })
highlight('WhichKeyGroup', { fg = p.foam })
highlight('WhichKeySeparator', { fg = p.subtle })
highlight('WhichKeyDesc', { fg = p.gold })
highlight('WhichKeyFloat', { bg = maybe.surface })
highlight('WhichKeyValue', { fg = p.rose })

-- luka-reineke/indent-blankline.nvim
highlight('IndentBlanklineChar', { fg = p.muted })
highlight('IndentBlanklineSpaceChar', { fg = p.muted })
highlight('IndentBlanklineSpaceCharBlankline', { fg = p.muted })

-- hrsh7th/nvim-cmp
highlight('CmpItemAbbr', { fg = p.subtle })
highlight('CmpItemAbbrDeprecated', { fg = p.subtle, strikethrough = true })
highlight('CmpItemAbbrMatch', { fg = p.text, bold = true })
highlight('CmpItemAbbrMatchFuzzy', { fg = p.text, bold = true })
highlight('CmpItemKind', { fg = p.subtle })
highlight('CmpItemKindClass', { fg = p.pine })
highlight('CmpItemKindFunction', { fg = p.rose })
highlight('CmpItemKindInterface', { fg = p.foam })
highlight('CmpItemKindMethod', { fg = p.iris })
highlight('CmpItemKindSnippet', { fg = p.gold })
highlight('CmpItemKindVariable', { fg = p.text })

-- TimUntersberger/neogit
highlight('NeogitDiffAddHighlight', { fg = p.foam, bg = p.highlight_med })
highlight('NeogitDiffContextHighlight', { bg = p.highlight_low })
highlight('NeogitDiffDeleteHighlight', { fg = p.love, bg = p.highlight_med })
highlight('NeogitHunkHeader', { bg = p.highlight_low })
highlight('NeogitHunkHeaderHighlight', { bg = p.highlight_low })

-- vimwiki/vimwiki
highlight('VimwikiHR', { fg = p.subtle })
highlight('VimwikiHeader1', { fg = groups.headings.h1, bold = true })
highlight('VimwikiHeader2', { fg = groups.headings.h2, bold = true })
highlight('VimwikiHeader3', { fg = groups.headings.h3, bold = true })
highlight('VimwikiHeader4', { fg = groups.headings.h4, bold = true })
highlight('VimwikiHeader5', { fg = groups.headings.h5, bold = true })
highlight('VimwikiHeader6', { fg = groups.headings.h6, bold = true })
highlight('VimwikiHeaderChar', { fg = p.pine })
highlight('VimwikiLink', { fg = groups.link, underline = true })
highlight('VimwikiList', { fg = p.iris })
highlight('VimwikiNoExistsLink', { fg = p.love })

-- nvim-neorg/neorg
highlight('NeorgHeading1Prefix', { fg = groups.headings.h1, bold = true })
highlight('NeorgHeading1Title', { link = 'NeorgHeading1Prefix' })
highlight('NeorgHeading2Prefix', { fg = groups.headings.h2, bold = true })
highlight('NeorgHeading2Title', { link = 'NeorgHeading2Prefix' })
highlight('NeorgHeading3Prefix', { fg = groups.headings.h3, bold = true })
highlight('NeorgHeading3Title', { link = 'NeorgHeading3Prefix' })
highlight('NeorgHeading4Prefix', { fg = groups.headings.h4, bold = true })
highlight('NeorgHeading4Title', { link = 'NeorgHeading4Prefix' })
highlight('NeorgHeading5Prefix', { fg = groups.headings.h5, bold = true })
highlight('NeorgHeading5Title', { link = 'NeorgHeading5Prefix' })
highlight('NeorgHeading6Prefix', { fg = groups.headings.h6, bold = true })
highlight('NeorgHeading6Title', { link = 'NeorgHeading6Prefix' })
highlight('NeorgMarkerTitle', { fg = p.text, bold = true })

-- tami5/lspsaga.nvim (fork of glepnir/lspsaga.nvim)
highlight('DefinitionCount', { fg = p.rose })
highlight('DefinitionIcon', { fg = p.rose })
highlight('DefintionPreviewTitle', { fg = p.rose, bold = true })
highlight('LspFloatWinBorder', { fg = groups.border })
highlight('LspFloatWinNormal', { bg = maybe.surface })
highlight('LspSagaAutoPreview', { fg = p.subtle })
highlight('LspSagaCodeActionBorder', { fg = groups.border })
highlight('LspSagaCodeActionContent', { fg = p.foam })
highlight('LspSagaCodeActionTitle', { fg = p.gold, bold = true })
highlight('LspSagaCodeActionTruncateLine', { link = 'LspSagaCodeActionBorder' })
highlight('LspSagaDefPreviewBorder', { fg = groups.border })
highlight('LspSagaDiagnosticBorder', { fg = groups.border })
highlight('LspSagaDiagnosticHeader', { fg = p.gold, bold = true })
highlight('LspSagaDiagnosticTruncateLine', { link = 'LspSagaDiagnosticBorder' })
highlight('LspSagaDocTruncateLine', { link = 'LspSagaHoverBorder' })
highlight('LspSagaFinderSelection', { fg = p.gold })
highlight('LspSagaHoverBorder', { fg = groups.border })
highlight('LspSagaLspFinderBorder', { fg = groups.border })
highlight('LspSagaRenameBorder', { fg = p.pine })
highlight('LspSagaRenamePromptPrefix', { fg = p.love })
highlight('LspSagaShTruncateLine', { link = 'LspSagaSignatureHelpBorder' })
highlight('LspSagaSignatureHelpBorder', { fg = p.pine })
highlight('ReferencesCount', { fg = p.rose })
highlight('ReferencesIcon', { fg = p.rose })
highlight('SagaShadow', { bg = p.overlay })
highlight('TargetWord', { fg = p.iris })

-- ray-x/lsp_signature.nvim
highlight('LspSignatureActiveParameter', { bg = p.overlay })

-- rlane/pounce.nvim
highlight('PounceAccept', { fg = p.love, bg = p.highlight_high })
highlight('PounceAcceptBest', { fg = p.base, bg = p.gold })
highlight('PounceGap', { link = 'Search' })
highlight('PounceMatch', { link = 'Search' })

local float_background = options.dim_nc_background
    and (options.disable_float_background and groups.panel_nc or groups.panel)
    or maybe.surface

-- ggandor/leap.nvim
highlight('LeapMatch', { link = 'MatchParen' })
highlight('LeapLabelPrimary', { link = 'IncSearch' })
highlight('LeapLabelSecondary', { fg = p.base, bg = p.pine })

-- nvim-telescope/telescope.nvim
highlight('TelescopeBorder', { fg = groups.border, bg = float_background })
highlight('TelescopeMatching', { fg = p.rose })
highlight('TelescopeNormal', { fg = p.subtle, bg = float_background })
highlight('TelescopePromptNormal', { fg = p.text, bg = float_background })
highlight('TelescopePromptPrefix', { fg = p.subtle })
highlight('TelescopeSelection', { fg = p.text, bg = p.overlay })
highlight('TelescopeSelectionCaret', { fg = p.rose, bg = p.overlay })
highlight('TelescopeTitle', { fg = p.subtle })

-- rcarriga/nvim-notify
highlight('NotifyINFOBorder', { fg = p.foam })
highlight('NotifyINFOTitle', { link = 'NotifyINFOBorder' })
highlight('NotifyINFOIcon', { link = 'NotifyINFOBorder' })
highlight('NotifyWARNBorder', { fg = p.gold })
highlight('NotifyWARNTitle', { link = 'NotifyWARNBorder' })
highlight('NotifyWARNIcon', { link = 'NotifyWARNBorder' })
highlight('NotifyDEBUGBorder', { fg = p.muted })
highlight('NotifyDEBUGTitle', { link = 'NotifyDEBUGBorder' })
highlight('NotifyDEBUGIcon', { link = 'NotifyDEBUGBorder' })
highlight('NotifyTRACEBorder', { fg = p.iris })
highlight('NotifyTRACETitle', { link = 'NotifyTRACEBorder' })
highlight('NotifyTRACEIcon', { link = 'NotifyTRACEBorder' })
highlight('NotifyERRORBorder', { fg = p.love })
highlight('NotifyERRORTitle', { link = 'NotifyERRORBorder' })
highlight('NotifyERRORIcon', { link = 'NotifyERRORBorder' })

-- rcarriga/nvim-dap-ui
highlight('DapUIVariable', { link = 'Normal' })
highlight('DapUIValue', { link = 'Normal' })
highlight('DapUIFrameName', { link = 'Normal' })
highlight('DapUIThread', { fg = p.gold })
highlight('DapUIWatchesValue', { link = 'DapUIThread' })
highlight('DapUIBreakpointsInfo', { link = 'DapUIThread' })
highlight('DapUIBreakpointsCurrentLine', { fg = p.gold, bold = true })
highlight('DapUIWatchesEmpty', { fg = p.love })
highlight('DapUIWatchesError', { link = 'DapUIWatchesEmpty' })
highlight('DapUIBreakpointsDisabledLine', { fg = p.muted })
highlight('DapUISource', { fg = p.iris })
highlight('DapUIBreakpointsPath', { fg = p.foam })
highlight('DapUIScope', { link = 'DapUIBreakpointsPath' })
highlight('DapUILineNumber', { link = 'DapUIBreakpointsPath' })
highlight('DapUIBreakpointsLine', { link = 'DapUIBreakpointsPath' })
highlight('DapUIFloatBorder', { link = 'DapUIBreakpointsPath' })
highlight('DapUIStoppedThread', { link = 'DapUIBreakpointsPath' })
highlight('DapUIDecoration', { link = 'DapUIBreakpointsPath' })
highlight('DapUIModifiedValue', { fg = p.foam, bold = true })

-- glepnir/dashboard-nvim
highlight('DashboardShortcut', { fg = p.love })
highlight('DashboardHeader', { fg = p.pine })
highlight('DashboardCenter', { fg = p.gold })
highlight('DashboardFooter', { fg = p.iris })

-- SmiteshP/nvim-navic
highlight('NavicIconsFile', { fg = p.base })
highlight('NavicIconsModule', { fg = p.rose })
highlight('NavicIconsNamespace', { fg = p.base })
highlight('NavicIconsPackage', { fg = p.base })
highlight('NavicIconsClass', { fg = p.foam })
highlight('NavicIconsMethod', { fg = p.iris })
highlight('NavicIconsProperty', { fg = p.foam })
highlight('NavicIconsField', { fg = p.foam })
highlight('NavicIconsConstructor', { fg = p.gold })
highlight('NavicIconsEnum', { fg = p.gold })
highlight('NavicIconsInterface', { fg = p.foam })
highlight('NavicIconsFunction', { fg = p.pine })
highlight('NavicIconsVariable', { fg = p.text })
highlight('NavicIconsConstant', { fg = p.gold })
highlight('NavicIconsString', { fg = p.gold })
highlight('NavicIconsNumber', { fg = p.gold })
highlight('NavicIconsBoolean', { fg = p.rose })
highlight('NavicIconsArray', { fg = p.gold })
highlight('NavicIconsObject', { fg = p.gold })
highlight('NavicIconsKey', { fg = p.iris })
highlight('NavicIconsKeyword', { fg = p.pine })
highlight('NavicIconsNull', { fg = p.love })
highlight('NavicIconsEnumMember', { fg = p.foam })
highlight('NavicIconsStruct', { fg = p.foam })
highlight('NavicIconsEvent', { fg = p.gold })
highlight('NavicIconsOperator', { fg = p.subtle })
highlight('NavicIconsTypeParameter', { fg = p.foam })
highlight('NavicText', { fg = p.subtle })
highlight('NavicSeparator', { fg = p.subtle })

-- folke/noice.nvim
highlight('NoiceCursor', { fg = p.highlight_high, bg = p.text })

-- echasnovski/mini.indentscope
highlight('MiniIndentscopeSymbol', { fg = p.highlight_med })
highlight('MiniIndentscopeSymbolOff', { fg = p.highlight_med })

-- goolord/alpha-nvim
highlight('AlphaHeader', { fg = p.pine })
highlight('AlphaButtons', { fg = p.foam })
highlight('AlphaShortcut', { fg = p.rose })
highlight('AlphaFooter', { fg = p.gold })

vim.g.terminal_color_0 = p.overlay -- black
vim.g.terminal_color_8 = p.subtle  -- bright black
vim.g.terminal_color_1 = p.love    -- red
vim.g.terminal_color_9 = p.love    -- bright red
vim.g.terminal_color_2 = p.pine    -- green
vim.g.terminal_color_10 = p.pine   -- bright green
vim.g.terminal_color_3 = p.gold    -- yellow
vim.g.terminal_color_11 = p.gold   -- bright yellow
vim.g.terminal_color_4 = p.foam    -- blue
vim.g.terminal_color_12 = p.foam   -- bright blue
vim.g.terminal_color_5 = p.iris    -- magenta
vim.g.terminal_color_13 = p.iris   -- bright magenta
vim.g.terminal_color_6 = p.rose    -- cyan
vim.g.terminal_color_14 = p.rose   -- bright cyan
vim.g.terminal_color_7 = p.text    -- white
vim.g.terminal_color_15 = p.text   -- bright white





local brown = '#d67e5c'
local melon = '#E0AFA0'
-- for testing purpose
local teal = '#17ff74'

h('@type.qualifier', '', p.subtle, '')
h('@keyword.operator', '', p.subtle, 'bold')
h('typescriptIdentifierName', '', p.subtle, '')
h('@constructor', '', melon, '')
h('typescriptClassName', '', brown, '')
h('typescriptClassBlock', '', brown, '')
h('@method.call', '', melon, '')
h('@method', '', melon, '')


highlight('typescriptVariable', { link = '@variable.builtin' })
highlight('typescriptClassKeyword', { link = '@variable.builtin' })
highlight('typescriptExport', { fg = p.subtle})
highlight('typescriptDefault', { fg = p.subtle})
h('typescriptIdentifier', '', melon, 'italic')

-- :hi link {from-group} NONE
vim.cmd("hi link Type NONE")
vim.cmd("hi link @type NONE")
h('typescriptTypeReference', '', melon,'')


return p
