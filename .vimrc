set nocompatible	" Use Vim defaults instead of 100% vi compatibility
" set termguicolors

" ==> Plugins ------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugins')

" Make sure you use single quotes

" Fundamental
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'

" Productive
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Appearance
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'

" Initialize plugin system
call plug#end()
filetype plugin indent on    

" ==> Plugin Settings ----------------------------------------------------

" NERDTree Settings
" open a NERDTree automatically when vim starts up
"autocmd vimenter * NERDTree
"open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd StdinReadPre * let s:std_in=1
" set NERDTree width
let NERDTreeWinSize=25
" bookmark
let NERDTreeShowBookmarks=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"key map to open NERDTree
map <space>n :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" default arrow symbols
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" vim-airline Settings
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline_theme='molokai_original'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'default'
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"
" rainbow config
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

" majutsushi/tagbar Settings
nmap <space>t :TagbarToggle<CR>

" easymotion/vim-easymotion Settings
" map <tab> <Plug>(easymotion-prefix)
" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
let g:EasyMotion_smartcase = 1
nmap <space><space> <Plug>(easymotion-s)
vmap <space><space> <Plug>(easymotion-s)

" deoplete Settings
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = expand("$HOME/app/anaconda3/bin/python")


" ==> General Settings ------------------------------------------------

syntax on
set modelines=0		
set backspace=2		" more powerful backspacing
set nu!
" set relativenumber
set autoindent
set cursorline
set clipboard=unnamed " 设置vim中默认使用选择缓冲区寄存器 "*
set autochdir " vim自动切换工作目录为当前文件所在目录
" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set mouse=a
set pastetoggle=<F10>
set encoding=utf-8 
" set laststatus=2

" search 
set ignorecase
set nohlsearch
set incsearch
set smartcase

" disable backup and swap files
set nobackup       " no backup files
set noswapfile     " no swap files
set nowritebackup  " only in case you don't want a backup file while editing
set noundofile     " no undo files

" tab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" ==> Key mapping -----------------------------------------------------------------

" resize window
nnoremap <c-=> <c-w>=
nnoremap <c-h> <c-w><
nnoremap <c-l> <c-w>>
nnoremap <c-j> <c-w>-
nnoremap <c-k> <c-w>+

" keys to move around the windows
nnoremap <TAB> <c-w>w

" edit
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-a> <ESC>I
inoremap <c-e> <ESC>A
inoremap <c-d> <delete>

cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <c-b>
cnoremap <c-d> <delete>

" switch buffers
noremap <silent><space>[ :bp<cr>
noremap <silent><space>] :bn<cr>
noremap <silent><space>1 :b! 1<cr>
noremap <silent><space>2 :b! 2<cr>
noremap <silent><space>3 :b! 3<cr>
noremap <silent><space>4 :b! 4<cr>
noremap <silent><space>5 :b! 5<cr>
noremap <silent><space>6 :b! 6<cr>
noremap <silent><space>7 :b! 7<cr>
noremap <silent><space>8 :b! 8<cr>
noremap <silent><space>9 :b! 9<cr>
noremap <silent><space>0 :b! 10<cr>

" for convenience
noremap <silent><space>w :w<cr>
noremap <silent><space>q :q<cr>

" nvim exit terminal mode
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif
nnoremap <silent><space>; :terminal<cr>

if has("gui_vimr")
  " Here goes some VimR specific settings like
  colorscheme evening

endif
" important!!!! The command below must be placed at the end of the .vimrc file
" set noesckeys

