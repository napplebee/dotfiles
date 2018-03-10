"let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

set cursorline
hi CursorLine   cterm=NONE ctermbg=239 ctermfg=NONE

autocmd BufNewFile,BufRead *.inc  set syntax=htmlcheetah
autocmd BufNewFile,BufRead *.tmpl  set syntax=htmlcheetah
autocmd BufNewFile,BufRead *.comp  set syntax=perl
autocmd BufNewFile,BufRead *.json  set syntax=perl

set tags=.git/tags,tags,./tags,./../tags

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'vim-perl/vim-perl'

call vundle#end() 

filetype on
filetype plugin on
filetype plugin indent on

syntax on
set tabstop=4
set autoindent
set shiftwidth=4 
set expandtab
set wrap
set number
set autoread

set backspace=indent,eol,start
set completeopt=longest,menuone

set ttyfast
set noswapfile
tab ball
set switchbuf=useopen
set visualbell t_vb= 
set novisualbell       
set enc=utf-8
set incsearch
set hlsearch 
set scrolloff=5
"it causes vim goes background on CentOS
"set shellcmdflag=-ic

set laststatus=2
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_detect_modified=1

" TagBar настройки
let g:tagbar_autofocus = 1
let NERDTreeIgnore=['\.swp$', '\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']  


" === Keybindings ===
map <F3> :TagbarToggle<CR>
map <F2> :NERDTreeToggle<CR>
map <F4> :Shell 
map <F5> :! b_sync 
map <F6> :Perlc %<CR>
map <F10> :set syntax=perl<CR>
map <M-v> :bd<CR> 	   
map <M-r> :close<CR> 	   
map <M-x> :bn<CR> 	   
map <M-z> :bp<CR> 	   
nmap <M-w> :wa<CR>
imap <M-w> <ESC>:wa<CR>

nmap HN <ESC>:set nonumber<CR>
nmap SN <ESC>:set number<CR>
nmap SQ <ESC>:mksession! ~/.vim/sessions/Session.vim<CR>:wqa<CR>
nmap SS <ESC>:mksession! ~/.vim/sessions/Session.vim<CR>
nmap SL <ESC>:source ~/.vim/sessions/Session.vim<CR>
nmap CS <ESC>:nohl<CR> 
nnoremap <silent> <c-t> <ESC>:resize -2<CR>
nnoremap <silent> <c-g> <ESC>:resize +2<CR>
nnoremap <silent> <c-f> <ESC>:vertical resize -2<CR>
nnoremap <silent> <c-h> <ESC>:vertical resize +2<CR>

noremap <silent> <c-u> :call smooth_scroll#up(25, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(25, 0, 2)<CR>


function! s:RunShellCommand(cmdline)
    echo a:cmdline
    let expanded_cmdline = a:cmdline
    for part in split(a:cmdline, ' ')
        if part[0] =~ '\v[%#<]'
            let expanded_part = fnameescape(expand(part))
            let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
        endif
    endfor
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:    ' . a:cmdline)
    call setline(2, 'Expanded Form:  ' .expanded_cmdline)
    call setline(3,substitute(getline(2),'.','=','g'))
    execute '$read !'. expanded_cmdline
    setlocal nomodifiable
    1
endfunction

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
command! -complete=file -nargs=* Git call s:RunShellCommand('git '.<q-args>)
command! -complete=file -nargs=* Perlc call s:RunShellCommand('perl -c '.<q-args>)
