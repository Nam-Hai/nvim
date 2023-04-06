function s:highlight(group, bg, fg, style)
  let gui = a:style == '' ? '' : 'gui=' . a:style
  let fg = a:fg == '' ? '' : 'guifg=' . a:fg
  let bg = a:bg == '' ? '' : 'guibg=' . a:bg
  exec 'hi ' . a:group . ' ' . bg . ' ' . fg  . ' ' . gui
endfunction


let subtle = '#908caa'
let teal = '#17ff74'
let brown = '#d67e5c'
 " h('@type', { fg = p.subtle, bg = p.subtle })
 " h('@variable', { fg = p.subtle, bg = p.subtle })

" h('@type.qualifier', { fg = p.subtle })
call s:highlight('@type.qualifier', '', subtle, '')
call s:highlight('@keyword.operator', '', subtle, 'bold')
" call s:highlight('typescriptIdentifierName', '', subtle, '')
call s:highlight('@constructor', '', brown, '')
" call s:highlight('typescriptTypeReference', '', brown,'')
call s:highlight('typescriptClassName', '', brown, '')
