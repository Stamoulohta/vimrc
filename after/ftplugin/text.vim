" Vim filetype plugin file
" Language:		text
" Maintainer:	George Stamoulis <g.a.stamoulis@gmail.com>
" Last Change:	2014-06-16

" Wrap lines
setlocal wrap
" at linebreak
setlocal linebreak
" but disable its list.
setlocal nolist

" Prevent vim from inserting
" linebreaks in newly entered text.
setlocal textwidth=0
setlocal wrapmargin=0
" Keep the original textwidth.
setlocal formatoptions+=l

" Move the cursor by displayed lines
" instead of phisical ones.
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
