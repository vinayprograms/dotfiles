" ---------- Customize editing experience ----------
set autowrite
set showmode
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2 smarttab
" set number ruler relativenumber
set autoindent smartindent
set conceallevel=2
set showcmd " show partially entered commands
set backspace=indent,eol,start
set showtabline=2

set breakindent linebreak breakindentopt=,min:40
set fo-=t   " don't auto-wrap text using text width
"set fo+=c   " autowrap comments using textwidth with leader
set fo-=r   " don't auto-insert comment leader on enter in insert
set fo-=o   " don't auto-insert comment leader on o/O in normal
set fo+=q   " allow formatting of comments with gq
set fo-=w   " don't use trailing whitespace for paragraphs
set fo-=a   " disable auto-formatting of paragraph changes
"set fo-=n   " don't recognized numbered lists
set fo+=j   " delete comment prefix when joining
set fo-=2   " don't use the indent of second paragraph line
"set fo-=v   " don't use broken 'vi-compatible auto-wrapping'
"set fo-=b   " don't use broken 'vi-compatible auto-wrapping'
set fo+=l   " long lines not broken in insert mode
set fo+=m   " multi-byte character line break support
set fo+=M   " don't add space before or after multi-byte char
set fo-=B   " don't add space between two multi-byte chars
set fo+=1   " don't break a line after a one-letter word

syntax on
filetype plugin indent on
set wildmenu
" mark trailing spaces as errors
match IncSearch '\s\+$'
" turn on default spell checking
set spell spelllang=en_us

" Status line
set statusline=             " Clear statusline first
set laststatus=2            " always show window info
set statusline+=%m          " modified
set statusline+=%r          " read only
set statusline+=%h         	" help status
set statusline+=%w         	" preview
set statusline+=\ %l,%c    	" line,col
set statusline+=\ (%p%%)   	" percent
set statusline+=%=         	" left/right separator
set statusline+=%f\ \ \ \		" relative file path
" character count + zettel limit warning
set statusline+=\ C:%{wordcount().chars}%{exists('g:show_warning')?'⚠️\ ':'\ \ '}
set statusline+=\ W:%{wordcount().words}	" word count


" Prevent truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

" search
set incsearch                          " search as you type
set hlsearch                           " highlight search terms
" pressing leader twice clears search
map <silent> <esc><esc> :let @/=""<CR>
set ignorecase                         " case insensitive
set smartcase                          " case sensitive for uppercase



" ---------- Tabbed editing ----------
autocmd VimEnter * tab all
if argc() > 1
  tab all
endif
command! -nargs=1 -complete=file T tabedit <args>
command! -nargs=1 -complete=file E tabedit <args>
cabbrev t T
cabbrev e E
nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tp :tabprevious<CR>
nnoremap <silent> tt :tabnew<CR>
nnoremap <silent> tc :tabclose<CR>

" ---------- key remaps for faster navigation ----------
" Use ';' instead of ':'. This requires only one key-combo instead of two
 nnoremap ;; :
" [copied from rwxrob] Make `Y` consistent with D and C (yank till end)
map Y y$
" Better page down and page up
noremap <C-n> <C-d>
noremap <C-p> <C-b>
" Clear search highlight
nnoremap <C-c> :nohl<CR><C-l>
let mapleader = ';'
nnoremap <leader>x :<C-u>.!<Space>
nnoremap <leader>X :r!!<CR>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" ---------- parentheses matching ----------
inoremap ( ()<Left>
inoremap () ()
inoremap { {}<Left>
inoremap {} {}
inoremap {<CR> {<CR>}<Esc>ko
inoremap ` ``<Left>
inoremap `` ``

" ---------- Custom behaviours ----------
" fzf support
set rtp+=/opt/homebrew/opt/fzf

" [copied from rwxrob] start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Autosave after 5 seconds of inactivity
set updatetime=5000
function! AutoSaveAllBuffers()
  let l:current_buffer = bufnr('%')
  let l:last_buffer = bufnr('$')
  let l:n = 1
  let l:any_saved = 0

  while l:n <= l:last_buffer
    if buflisted(l:n) && getbufvar(l:n, '&modified') && !empty(bufname(l:n))
      execute 'silent! update ' . fnameescape(bufname(l:n))
      let l:any_saved = 1
    endif
    let l:n = l:n + 1
  endwhile

  if l:any_saved
    echo "Buffers autosaved"
    sleep 1
  endif
endfunction

augroup autosave_on_idle
  autocmd!
  autocmd CursorHold,CursorHoldI * call AutoSaveAllBuffers()
augroup END

" Warn after 1000 characters. Useful for Zettelkasten
" Blinking animation
function! BlinkZettelWarning(timer_id)
	" Check total number of characters
	let totalChars = strlen(join(getline(1, '$'), "\n"))
	" Toggle the warning symbol based on character count and current
	" visibility
	if totalChars >= 5000 && !exists('g:show_warning')
			let g:show_warning = 1
	elseif exists('g:show_warning')
		unlet g:show_warning
	endif
	" Trigger status line update
	redrawstatus
endfunction
" Function to toggle zettel warning
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

" search
set incsearch                          " search as you type
set hlsearch                           " highlight search terms
" pressing leader twice clears search
map <silent> <esc><esc> :let @/=""<CR>
set ignorecase                         " case insensitive
set smartcase                          " case sensitive for uppercase

" If using tmux, set the pane title to the file opened by vim. On exit, reset
" the name to the shell name.
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window " . fnamemodify($SHELL, ':t'))

" ----- Additional settings (copied from rwxrob's dotfiles) -----
" base default color changes (gruvbox dark friendly)
hi StatusLine ctermfg=darkgray guifg=darkgray ctermbg=NONE guibg=NONE
hi StatusLineNC ctermfg=darkgray guifg=darkgray ctermbg=NONE guibg=NONE
hi Normal ctermbg=NONE guibg=NONE
hi Special ctermfg=cyan guifg=cyan
hi LineNr ctermfg=gray guifg=gray ctermbg=NONE guibg=NONE
hi SpecialKey ctermfg=darkgray ctermbg=NONE
hi ModeMsg ctermfg=darkgray cterm=NONE ctermbg=NONE
hi MoreMsg ctermfg=black ctermbg=NONE
hi NonText ctermfg=black ctermbg=NONE
hi vimGlobal ctermfg=black ctermbg=NONE
hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
hi Error ctermbg=234 ctermfg=darkred cterm=NONE
" hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
" hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
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
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
au FileType * hi SpellBad ctermfg=NONE ctermbg=NONE cterm=undercurl gui=undercurl guisp=red
au FileType * hi SpellCap ctermfg=NONE ctermbg=NONE cterm=undercurl gui=undercurl guisp=yellow
au FileType * hi SpellRare ctermfg=NONE ctermbg=NONE cterm=undercurl gui=undercurl guisp=blue
au FileType * hi SpellLocal ctermfg=NONE ctermbg=NONE cterm=undercurl gui=undercurl guisp=orange
au FileType * hi Search ctermbg=236 ctermfg=darkred
au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
au FileType * hi Todo ctermbg=236 ctermfg=darkred
au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
au FileType * hi MatchParen ctermbg=236 ctermfg=darkred
au FileType yaml hi yamlBlockMappingKey ctermfg=NONE
au FileType yaml set sw=2
au FileType bash set sw=2
au FileType c set sw=8

" ---------- markdown specific settings ----------
let g:vim_markdown_math = v:true
let g:vim_markdown_strikethrough=v:true
highlight mkdStrike ctermfg=lightgray guifg=lightgray cterm=strikethrough gui=strikethrough
au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE cterm=bold
au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE cterm=bold
au FileType markdown,pandoc hi htmlBold ctermfg=254 cterm=bold
au FileType markdown,pandoc hi markdownCode ctermfg=darkblue ctermbg=NONE
au FileType markdown,pandoc set tw=0
au FileType markdown setlocal shiftwidth=2 softtabstop=2
autocmd FileType markdown syntax enable
au FileType markdown syntax match mkdCheckedItem /\s*- \[x\].*/
au FileType markdown syntax match mkdCheckedItem /\s*- \[X\].*/
au FileType markdown hi mkdCheckedItem cterm=strikethrough gui=strikethrough ctermfg=darkgray guifg=darkgray

" Use `m` as a leader key for markdown operations
"let mapleader = "m"

" Make the current word bold, italic, or strikethrough
nnoremap mb :call MarkdownWrapWord('**')<CR>
xnoremap mb :<C-u>call MarkdownWrap('**')<CR>
nnoremap mgb :call MarkdownWrapLine('**')<CR>

nnoremap mi :call MarkdownWrapWord('*')<CR>
xnoremap mi :<C-u>call MarkdownWrap('*')<CR>
nnoremap mgi :call MarkdownWrapLine('*')<CR>

nnoremap ms :call MarkdownWrapWord('~~')<CR>
xnoremap ms :<C-u>call MarkdownWrap('~~')<CR>
nnoremap mgs :call MarkdownWrapLine('~~')<CR>

" Toggle a checkbox without requiring selection
nnoremap mx :call ToggleMarkdownCheckbox()<CR>

" Functions for markdown operations
" Functions to handle wrapping and toggling
function! MarkdownWrap(mark)
    " Wrap the visually selected text with the markdown mark
    let l:mark = a:mark
    let l:text = getline("'<")[getpos("'<")[2]-1 : getpos("'>")[2]-2]
    call setline('.', substitute(getline('.'), l:text, l:mark . l:text . l:mark, ''))
endfunction

function! MarkdownWrapWord(mark)
    " Wrap the current word under the cursor with the markdown mark
    let l:mark = a:mark
    " Visually select the word
    execute "normal! viw"
    " Wrap it with marks
    execute "normal! c" . l:mark . "\<C-r>\"" . l:mark
endfunction

function! MarkdownWrapLine(mark)
    " Wrap the entire current line with the markdown mark
    let l:mark = a:mark
    " Move to the beginning of the line
    execute "normal! 0"  
    execute "normal! c" . l:mark . getline('.') . l:mark
endfunction

function! ToggleMarkdownCheckbox()
    " Toggle a markdown checkbox between [ ] and [x]
    let l:line = getline('.')
    if l:line =~ '\s*- \[ \]'
        execute "s/\\v^\(\\s*\)- \\[ \\]/\\1- \\[x\\]/"
    elseif l:line =~ '\s*- \[\(x\|X\)\]'
        execute "s/\\v^\(\\s*\)- \\[\(x\|X\)\\]/\\1- \\[ \\]/"
    endif
endfunction

" ---------- Go specific settings ----------
let g:ale_sign_error = '☠'
let g:ale_sign_warning = '🙄'
let g:ale_linters = {'go': ['gometalinter', 'gofmt','gobuild']}
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 50vnew',
      \ 'out':        'botright 5new',
      \ }
let g:go_debug_config = {
    \ 'variables': {
    \ 'exclude_categories': ['Registers']
    \}
\ }
let g:go_debug_mappings = {
      \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
      \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
      \ '(go-debug-step)': {'key': 's'},
      \ '(go-debug-print)': {'key': 'p'},
  \}
let g:go_debug_log_output = ''
map gds :GoDebugStop<cr>
map gdb :GoDebugBreakpoint<cr>

" ---------- Github Copilot ----------
" Disable Copilot on startup
let g:copilot_enabled = v:false

" ---------- ctags ----------
let mapleader = ","
nnoremap ,t :tag <C-R><C-W><CR>
nnoremap ,b :pop<CR>
nnoremap ,n :tnext<CR>
nnoremap ,p :tprev<CR>

" ---------- delete versus cut-paste ----------
" Remap `d` and `x` to avoid yanking in normal mode
nnoremap d "_d
nnoremap x "_x
" Allow cut-paste in Visual mode by not overriding `d` and `x` in Visual mode
xnoremap <silent> d d
xnoremap <silent> x x

" ---------- folding ----------
set foldenable foldmethod=indent
set foldlevel=99
" Use <tab> in normal mode to toggle fold
nnoremap <tab> za

" ---------- Better mode visuals ----------
" Define highlight groups for different modes
highlight StatusLineNormal ctermfg=darkgray ctermbg=black guifg=#ffffff guibg=#005f87
highlight StatusLineInsert ctermfg=black ctermbg=red guifg=#000000 guibg=#5f8700
highlight StatusLineVisual ctermfg=black ctermbg=cyan guifg=#000000 guibg=#d7af5f
highlight StatusLineReplace ctermfg=black ctermbg=yellow guifg=#000000 guibg=#af0000

" Function to update the status line based on mode
function! UpdateStatusLineColor()
    let l:mode = mode()
    if l:mode == 'n'
        hi! link StatusLine StatusLineNormal
    elseif l:mode == 'i'
        hi! link StatusLine StatusLineInsert
    elseif l:mode == 'v' || l:mode == 'V' || l:mode == '^V'
        hi! link StatusLine StatusLineVisual
    elseif l:mode == 'R'
        hi! link StatusLine StatusLineReplace
    endif
endfunction


" Trigger the function on various mode change events
autocmd InsertEnter,InsertLeave * call UpdateStatusLineColor()
autocmd CmdlineEnter,CmdlineLeave * call UpdateStatusLineColor()
autocmd BufEnter,BufLeave * call UpdateStatusLineColor()
autocmd WinEnter,WinLeave * call UpdateStatusLineColor()
autocmd CursorHold * call UpdateStatusLineColor()
autocmd CursorMoved * call UpdateStatusLineColor()
autocmd ModeChanged * call UpdateStatusLineColor()

" Update the status line on startup
autocmd VimEnter * call UpdateStatusLineColor()

" Change cursor shape for better visuals
if has("termguicolors")
  let &t_SI = "\e[5 q" " Blinking bar for Insert mode
  let &t_SR = "\e[4 q" " Blinking underline for Replace mode
  let &t_EI = "\e[1 q" " Block cursor for Normal mode
endif

" ---------- language servers ----------

function! GoToTagIfOnlyOne()
    " Save the current tag stack before executing g]
    let l:taglist = taglist(expand('<cword>'))
    if len(l:taglist) == 1
        " If only one tag match, jump to it directly
        execute 'tag ' . l:taglist[0].name
    else
        " Otherwise, show the usual tag selection list
        execute 'tjump ' . expand('<cword>')
    endif
endfunction

" Map gd to call the custom function
nnoremap <silent> gd :call GoToTagIfOnlyOne()<CR>

nnoremap gh <C-o>
nnoremap gl <C-i>

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_auto_enable = 1

" Bash LSP
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->['bash-language-server', 'start']},
        \ 'whitelist': ['sh', 'bash'],
        \ })
endif

" YAML LSP
if executable('yaml-language-server')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'yaml-language-server',
				\ 'cmd': {server_info->['yaml-language-server', '--stdio']},
				\ 'whitelist': ['yaml','yml'],
				\ })
endif

" Python LSP
if executable('pylsp')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'pylsp',
				\ 'cmd': {server_info->['pylsp']},
				\ 'whitelist': ['python'],
				\ })
endif

" go LSP settings
let g:go_auto_type_info = 0
let g:ale_sign_error = '☠'
let g:ale_sign_warning = '🙄'
let g:ale_linters = {'go': ['gometalinter', 'gofmt','gobuild']}

" Disable Copilot on startup
let g:copilot_enabled = v:false

let g:fzf_layout = { 'down': '~40%' }
autocmd VimEnter * if isdirectory(expand('%')) | call fzf#run(fzf#wrap({'source': 'find . -type f', 'sink': 'e'})) | endif

