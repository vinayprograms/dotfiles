set nu
set tabstop=2 shiftwidth=2 smarttab
set conceallevel=2
set breakindent
set breakindentopt=,min:40
set wrap linebreak
syntax on

" Status line
set laststatus=2                    			" always show window info
set statusline+=%m                  			" modified
set statusline+=%r                  			" readonly
set statusline+=%h                  			" helpstatus 
set statusline+=%w                  			" preview 
set statusline+=\ %l,%c             			" line,col
set statusline+=\ (%p%%)            			" percent
set statusline+=%=                  			" left/right sep
set statusline+=%f                  			" relative filepath
set statusline+=\ C:%{wordcount().chars}	" character count
set statusline+=\ W:%{wordcount().words}	" word count

" Prevent truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

" Syntax highlighting
au BufRead,BufNewFile *.adm set syntax=cucumber

" search
set incsearch                          " search as you type
set hlsearch                           " highlight search terms
map <silent> <esc><esc> :let @/=""<CR> " pressing leader twice clears search
set ignorecase                         " case insensitive
set smartcase                          " case sensitive for uppercase

" Attack Defense modeling
" au BufNewFile,BufRead *.adm,*.adspec call SetFileTypeSH("feature")

" ----- Additional settings (copied from rwxrob's dotfiles) -----

" base default color changes (gruvbox dark friendly)
hi StatusLine ctermfg=darkgray ctermbg=NONE
hi StatusLineNC ctermfg=darkgray ctermbg=NONE
hi Normal ctermbg=NONE
hi Special ctermfg=cyan
hi LineNr ctermfg=gray ctermbg=NONE
hi SpecialKey ctermfg=darkgray ctermbg=NONE
hi ModeMsg ctermfg=darkgray cterm=NONE ctermbg=NONE
hi MoreMsg ctermfg=black ctermbg=NONE
hi NonText ctermfg=black ctermbg=NONE
hi vimGlobal ctermfg=black ctermbg=NONE
hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
hi Error ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
hi Search ctermbg=236 ctermfg=darkred
hi vimTodo ctermbg=236 ctermfg=darkred
hi Todo ctermbg=236 ctermfg=darkred
hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
hi MatchParen ctermbg=236 ctermfg=darkred

" color overrides
au FileType * hi Normal ctermbg=NONE
au FileType * hi Special ctermfg=cyan
au FileType * hi goComment ctermfg=black ctermbg=NONE
au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Search ctermbg=236 ctermfg=darkred
au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
au FileType * hi Todo ctermbg=236 ctermfg=darkred
au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
au FileType * hi MatchParen ctermbg=236 ctermfg=darkred
au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE cterm=bold
au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE cterm=bold
au FileType markdown,pandoc hi markdownCode ctermfg=darkblue ctermbg=NONE
au FileType markdown,pandoc set tw=0
au FileType yaml hi yamlBlockMappingKey ctermfg=NONE
au FileType yaml set sw=2
au FileType bash set sw=2
au FileType c set sw=8
au FileType markdown,pandoc noremap j gj
au FileType markdown,pandoc noremap k gk
