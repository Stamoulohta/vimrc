" Vim filetype plugin file
" Language:		python
" Maintainer:	George Stamoulis <g.a.stamoulis@gmail.com>
" Last Change:	January 06 2013

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let s:keepcpo= &cpo
set cpo&vim

setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal include=\s*\\(from\\\|import\\)
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal suffixesadd=.py
setlocal comments-=:%
setlocal commentstring=#%s

setlocal omnifunc=pythoncomplete#Complete

" My additions.
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

set wildignore+=*.pyc

nnoremap <silent> <buffer> ]] :call <SID>Python_jump('/^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [[ :call <SID>Python_jump('?^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ]m :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [m :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>

if exists('*<SID>Python_jump') | finish | endif

fun! <SID>Python_jump(motion) range
	let cnt = v:count1
	let save = @/    " save last search pattern
	mark '
	while cnt > 0
		silent! exe a:motion
		let cnt = cnt - 1
	endwhile
	call histdel('/', -1)
	let @/ = save    " restore last search pattern
endfun

if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "Python Files (*.py)\t*.py\n" .
		       \ "All Files (*.*)\t*.*\n"
endif

let &cpo = s:keepcpo
unlet s:keepcpo
