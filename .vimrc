""" IBM manuals:
"""	http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
"""	http://www.ibm.com/developerworks/linux/library/l-vim-script-2/index.html
"""	http://www.ibm.com/developerworks/linux/library/l-vim-script-3/index.html
"""	http://www.ibm.com/developerworks/linux/library/l-vim-script-4/index.html
"""	http://www.ibm.com/developerworks/linux/library/l-vim-script-5/index.html
"""
""" Pythoncomplete plugin:
"""	http://www.vim.org/scripts/script.php?script_id=1542
"""
""" Mapping keys:
"""	http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
"""
""" Vim Regexps:
"""	http://www.softpanorama.org/Editors/Vimorama/vim_regular_expressions.shtml
"""
""" Misc:
"""	http://habrahabr.ru/blogs/vim/102373/
"""	http://habrahabr.ru/blogs/vim/28572/
"""	http://aufather.wordpress.com/2010/08/26/omni-completion-in-vim/
"""	http://vim.runpaint.org/other-uses-vim/browsing-directories/
"""	http://unixforum.org/index.php?showforum=110


""" Indents
set ts=4
set sw=4
au FileType python setl sw=4 sts=4 et
au FileType yaml setl sw=4 sts=4 et


""" Common settings
syntax on
set t_Co=8
colorscheme default
set encoding=utf8
autocmd SourcePre * set t_Co=8

set hlsearch
set incsearch
set ignorecase
set wildmenu
set wcm=<Tab>
set nobackup
autocmd BufEnter * lcd %:p:h " set autochdir

set completeopt-=preview
set completeopt+=longest


""" Keybindings
inoremap <S-Tab> <C-V><Tab>

nmap <C-e> :Explore<Cr>
nmap <C-t> :tabnew<Cr>
nmap <C-c> :tabclose<Cr>
nmap <C-d> :bd<Cr>
nmap <C-Right> :tabn<Cr>
nmap <C-Left> :tabp<Cr>

nmap <C-b>Right :bn<Cr>
nmap <C-b>Left :bp<Cr>

if bufwinnr(1)
	nmap + <C-W>+
	nmap - <C-W>-
	nmap > <C-W>>
	nmap < <C-W><
endif

function! InsertTabWrapper()
	let line = matchstr(strpart(getline("."), -2, col('.') + 1), "[^ \t\*#\|,;:]*$")
	if ( strlen(line) == 0 )
		return "\<Tab>"
	endif

	if ( line =~ "\/" )
		return "\<C-x>\<C-f>"
	else
		return "\<C-p>"
	fi
endfunction
imap <Tab> <C-r>=InsertTabWrapper()<Cr>


""" Spaces refactoring
menu SpacesRefactoring.[2\ Spaces\ to\ Tab] :%s#^\( \{2}\)\+#\=repeat("\t", len(submatch(0))/2)#g<Cr>
menu SpacesRefactoring.[4\ Spaces\ to\ Tab] :%s#^\( \{4}\)\+#\=repeat("\t", len(submatch(0))/4)#g<Cr>
menu SpacesRefactoring.[6\ Spaces\ to\ Tab] :%s#^\( \{6}\)\+#\=repeat("\t", len(submatch(0))/6)#g<Cr>
menu SpacesRefactoring.[8\ Spaces\ to\ Tab] :%s#^\( \{8}\)\+#\=repeat("\t", len(submatch(0))/8)#g<Cr>

menu SpacesRefactoring.[Tab\ to\ 2\ Spaces] :%s#^\(\t\+\)#\=repeat(" ", len(submatch(0))*2)#g<Cr>
menu SpacesRefactoring.[Tab\ to\ 4\ Spaces] :%s#^\(\t\+\)#\=repeat(" ", len(submatch(0))*4)#g<Cr>
menu SpacesRefactoring.[Tab\ to\ 6\ Spaces] :%s#^\(\t\+\)#\=repeat(" ", len(submatch(0))*6)#g<Cr>
menu SpacesRefactoring.[Tab\ to\ 8\ Spaces] :%s#^\(\t\+\)#\=repeat(" ", len(submatch(0))*8)#g<Cr>

nmap <F2> :emenu SpacesRefactoring.<Tab>


"""
augroup twig_ft
	au!
	autocmd BufNewFile,BufRead *.pug   set syntax=pug
augroup END

augroup ft_c
	au!
	au BufEnter *.c setf c
	au BufEnter *.h setf c
	autocmd Syntax c syn match cType "\<[a-zA-Z_][a-zA-Z0-9_]*_[tseuf]\>"
augroup end
