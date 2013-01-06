" My custom support file to detect file types.
"
" Maintainer:		George Stamoulis <g.a.stamoulis@gmail.com>
" Last Change:		January 06 2013

finish " XXX Remove this to enable this file.

" Do this only if needed.
if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	au! BufNewFile,BufRead *.py,*.pyw setfiletype python
augroup END
