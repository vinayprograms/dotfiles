set nu
set autowrite
set showmode
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2 " smarttab
set number ruler
set autoindent smartindent
set conceallevel=2
set breakindent
set breakindentopt=,min:40
syntax on

filetype plugin indent on

" fzf support
set rtp+=/opt/homebrew/opt/fzf

" mark trailing spaces as errors
match IncSearch '\s\+$'
" enough for line numbers + gutter within 80 standard
set textwidth=72
set colorcolumn=73

" turn on default spell checking
"set spell

" allow sensing the file type
filetype plugin on

" Warn after 1000 characters. Useful for Zettelkasten
" Function to toggle warning visibility (blinking animation)
function! BlinkZettelWarning(timer_id)
	" Check total number of characters
	let totalChars = strlen(join(getline(1, '$'), "\n"))
	" Toggle the warning symbol based on character count and current
	" visibility
	if totalChars >= 1500 && !exists('g:show_warning')
			let g:show_warning = 1
	elseif exists('g:show_warning')
		unlet g:show_warning
	endif
	" Trigger status line update
	redrawstatus
endfunction

" Function to toggle display of zettel limit warning
function! ToggleZettelWarning()
	" Check if blinking timer exists and is active
	if exists('s:blink_timer')
		"Timer exists. Stop it and clear warning
		call timer_stop(s:blink_timer)
		unlet s:blink_timer
		if exists('g:show_warning')
			unlet g:show_warning
		endif
	else
		" Timer doesn't exist. Start it
		let s:blink_timer = timer_start(500, 'BlinkZettelWarning', {'repeat': -1})
	endif
	" Update status line to reflect change
	redrawstatus
endfunction

command! ZetWarn call ToggleZettelWarning()

" Start timer to blink zettel warning
let s:blink_timer = timer_start(500, 'BlinkZettelWarning', {'repeat': -1})


" Status line
set laststatus=2                    			" always show window info
set statusline+=%m                  			" modified
set statusline+=%r                  			" read only
set statusline+=%h                  			" help status 
set statusline+=%w                  			" preview 
set statusline+=\ %l,%c             			" line,col
set statusline+=\ (%p%%)            			" percent
set statusline+=%=                  			" left/right separator
set statusline+=%f\ \ \ \            			" relative file path
" character count + zettel limit warning
set statusline+=\ C:%{wordcount().chars}%{exists('g:show_warning')?'⚠️\ ':'\ \ '} 
set statusline+=\ W:%{wordcount().words}	" word count

" Prevent truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

" Syntax highlighting
au BufRead,BufNewFile *.adm set syntax=cucumber

" search
set incsearch                          " search as you type
set hlsearch                           " highlight search terms
" pressing leader twice clears search
map <silent> <esc><esc> :let @/=""<CR> 
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
au FileType * hi goComment ctermfg=darkgray ctermbg=NONE
au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Search ctermbg=236 ctermfg=darkred
au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
au FileType * hi Todo ctermbg=236 ctermfg=darkred
au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
au FileType * hi MatchParen ctermbg=236 ctermfg=darkred
au FileType yaml hi yamlBlockMappingKey ctermfg=NONE
au FileType yaml set sw=2
au FileType bash set sw=2
au FileType c set sw=8

" markdown specific settings
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough=1
highlight mkdStrike ctermfg=lightgray guifg=lightgray cterm=strikethrough gui=strikethrough
au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE cterm=bold
au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE cterm=bold
au FileType markdown,pandoc hi markdownCode ctermfg=darkblue ctermbg=NONE
au FileType markdown,pandoc set tw=0
au FileType markdown setlocal shiftwidth=2 softtabstop=2
autocmd FileType markdown syntax enable
au FileType markdown,pandoc noremap j gj
au FileType markdown,pandoc noremap k gk
au FileType markdown syntax match mkdCheckedItem /\s*- \[x\].*/
au FileType markdown syntax match mkdCheckedItem /\s*- \[X\].*/
au FileType markdown hi mkdCheckedItem cterm=strikethrough gui=strikethrough ctermfg=darkgray guifg=darkgray

" Go specific settings
let g:ale_sign_error = '☠'
let g:ale_sign_warning = '🙄'
let g:ale_linters = {'go': ['gometalinter', 'gofmt','gobuild']}

