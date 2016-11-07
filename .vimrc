"set t_Co=256
set bg=dark
colorscheme gruvbox
set nocompatible              " be iMproved, required
filetype off                  " required


"=====================================================
" Vundle settings
"=====================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'		" let Vundle manage Vundle, required

"------=== Start screen ===----------
Plugin 'mhinz/vim-startify'

"---------=== Code/project navigation ===-------------
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'          	" Class/module browser
Plugin 'ctrlpvim/ctrlp.vim'

"------------------=== Other ===----------------------
Plugin 'bling/vim-airline'   	    	" Lean & mean status/tabline for vim
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'rosenfeld/conque-term'      	" Consoles as buffers
Plugin 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more
Plugin 'terryma/vim-smooth-scroll'

"--------------=== Snippets support ===---------------
Plugin 'garbas/vim-snipmate'		" Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'	" dependencies #1
Plugin 'tomtom/tlib_vim'		" dependencies #2
Plugin 'honza/vim-snippets'		" snippets repo

"---=== Perl specific plugins ===---
Plugin 'vim-perl/vim-perl'

"---------------=== Languages support ===-------------
call vundle#end()            		" required
filetype on
filetype plugin on
filetype plugin indent on

"starting page
let g:startify_bookmarks = ['~/.vimrc','~/.bashrc',]
let g:startify_custom_header = map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']
let g:startify_session_persistence = 1
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
"end of starting page

syntax on
set tabstop=4 "display all occurrences of Tab character (ASCII #9) as 4 spaces. This option will not change the text, it will only change the displaying of the text.
set autoindent "automatically position the cursor with appropriate indentation level when you press Enter and want to write the next line of code
set shiftwidth=4 "control the width of the indentation level when you select a block of code and change it’s indentation level
set expandtab
set wrap
set number "if you want to see all lines numbered
set autoread

"==== settings from habrahabr
set backspace=indent,eol,start
"let no_buffers_menu=1

set completeopt=longest,menuone

set ttyfast
" === review down further ====
set noswapfile
tab ball
set switchbuf=useopen

"отключаем пищалку и мигание
set visualbell t_vb= 
set novisualbell       

set enc=utf-8     " utf-8 по дефолту в файлах
set incsearch     " инкреминтируемый поиск
set hlsearch     " подсветка результатов поиска
set scrolloff=5     " 	5 строк при скролле за раз
set shellcmdflag=-ic " делаем шелл вима интерактивным (алиасы из .bashrc)

" указываем каталог с настройками SnipMate
"let g:snippets_dir = "~/.vim/vim-snippets/snippets"
"
" настройки Vim-Airline
set laststatus=2
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_detect_modified=1

" TagBar настройки
let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии

"NerdTree настройки
"игноррируемые файлы с расширениями
let NERDTreeIgnore=['\.swp$', '\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']  


" === Keybindings ===
map <F3> :TagbarToggle<CR>
map <F2> :NERDTreeToggle<CR>
map <F5> :! b_sync 
map <F6> :! tmpl_sync 

" Работа буфферами
map <C-x> :close<CR> 	   
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
nnoremap <silent> <C-S-Up> <ESC>:resize -2<CR>
nnoremap <silent> <C-S-Down> <ESC>:resize +2<CR>
nnoremap <silent> <C-S-Left> <ESC>:vertical resize -2<CR>
nnoremap <silent> <C-S-Right> <ESC>:vertical resize +2<CR>

"smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(25, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(25, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(40, 0, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(40, 0, 2)<CR>

set cursorline
hi CursorLine   cterm=NONE ctermbg=239 ctermfg=NONE


autocmd BufNewFile,BufRead *.inc  set syntax=htmlcheetah
autocmd BufNewFile,BufRead *.tmpl  set syntax=htmlcheetah

set tags=.git/tags,tags,./tags,./../tags
