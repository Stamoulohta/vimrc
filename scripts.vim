" My custom scripts file.
"
" Maintainer:		George Stamoulis <g.a.stamoulis@gmail.com>
" Last Change:		January 06 2013

finish				" XXX Remove this to enable this file.

if did_filetype()	" Filetype is already set..
	finish			" ..don't do these checks.
endif

" Example...
if getline(1) =~ '^#!.*\<python2\>'
	setfiletype python
elseif getline(1) =~ '^#!.*\<python3\>'
	setfiletype python3
endif
