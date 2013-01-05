" Vim support file to detect file types
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2012 Feb 03

" Listen very carefully, I will say this only once
if exists("did_load_filetypes")
  finish
endif
let did_load_filetypes = 1

" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

augroup filetypedetect

" Abaqus or Trasys
au BufNewFile,BufRead *.inp			call s:Check_inp()

func! s:Check_inp()
  if getline(1) =~ '^\*'
    setf abaqus
  else
    let n = 1
    if line("$") > 500
      let nmax = 500
    else
      let nmax = line("$")
    endif
    while n <= nmax
      if getline(n) =~? "^header surface data"
	setf trasys
	break
      endif
      let n = n + 1
    endwhile
  endif
endfunc

" A-A-P recipe
au BufNewFile,BufRead *.aap			setf aap
" C++

au BufNewFile,BufRead *.cxx,*.c++,*.hh,*.hxx,*.hpp,*.ipp,*.moc,*.tcc,*.inl setf cpp
if has("fname_case")
  au BufNewFile,BufRead *.C,*.H setf cpp
endif

" .h files can be C, Ch C++, ObjC or ObjC++.
" Set c_syntax_for_h if you want C, ch_syntax_for_h if you want Ch. ObjC is
" detected automatically.
au BufNewFile,BufRead *.h			call s:FTheader()

func! s:FTheader()
  if match(getline(1, min([line("$"), 200])), '^@\(interface\|end\|class\)') > -1
    setf objc
  elseif exists("g:c_syntax_for_h")
    setf c
  elseif exists("g:ch_syntax_for_h")
    setf ch
  else
    setf cpp
  endif
endfunc
" Generic configuration file (check this last, it's just guessing!)
au BufNewFile,BufRead,StdinReadPost *
	\ if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat
	\    && (getline(1) =~ '^#' || getline(2) =~ '^#' || getline(3) =~ '^#'
	\	|| getline(4) =~ '^#' || getline(5) =~ '^#') |
	\   setf conf |
	\ endif

augroup END


"**************************************************************************

" If the GUI is already running, may still need to install the Syntax menu.
" Don't do it when the 'M' flag is included in 'guioptions'.
if has("menu") && has("gui_running")
      \ && !exists("did_install_syntax_menu") && &guioptions !~# "M"
  source <sfile>:p:h/menu.vim
endif

" Function called for testing all functions defined here.  These are
" script-local, thus need to be executed here.
" Returns a string with error messages (hopefully empty).
func! TestFiletypeFuncs(testlist)
  let output = ''
  for f in a:testlist
    try
      exe f
    catch
      let output = output . "\n" . f . ": " . v:exception
    endtry
  endfor
  return output
endfunc

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
