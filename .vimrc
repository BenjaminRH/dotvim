"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Benjamin R. Harris
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Plugin settings
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Be iMproved
set nocompatible

" Enable pathogen so it can be in the bundle directory like everything else
runtime bundle/vim-pathogen/autoload/pathogen.vim

" Turn on pathogen
execute pathogen#infect()

" Enable filetype plugins
filetype plugin indent on

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" Set the leader
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast mode escape
inoremap ii <Esc>

" Get the shell sorted out properly (fix issues with zsh, etc.)
set shell=bash
let g:is_bash=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight the current line
set cursorline

" Show a symbol indicating the end of the position you're changing
"set cpoptions+=$

" Have some space around the current line when moving vertically
set scrolloff=3

" When scrolling downwards, advance cursor by this many lines
set scrolljump=1

" Have some space around the current line when moving horizontally
set sidescrolloff=15

" When scrolling sideways, advance cursor by this many characters
set sidescroll=1

" Add non-relative line numbers
set number

"Always show current position
set ruler

" Show how many characters/lines are selected
set showcmd

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Ignore case when searching
set ignorecase

" Don't ignore the case if the search contains at least one capital letter
set smartcase

" Make the search "g" flag (:s/x/y/g) be on by default
set gdefault

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" Also match angle brackets
set matchpairs+=<:>

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Hide some GUI crap
set guioptions-=m " No menu bar
set guioptions-=T " No toolbar
set guioptions-=r " No scrollbar (right)
set guioptions-=R " No scrollbar (right, on vertical split windows)
set guioptions-=l " No scrollbar (left)
set guioptions-=L " No scrollbar (left, on vertical split windows)
set guioptions-=b " No scrollbar (bottom)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" Set the colorscheme background
set background=light

" Set the colorscheme
colorscheme solarized

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Recognize markdown files
autocmd BufRead,BufNewFile *.md set filetype=markdown


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Linebreak on 500 characters
" set linebreak
" set textwidth=500

" Auto indent
set autoindent

" Smart indent
set smartindent

" Do not wrap lines
set nowrap

" But wrap lines for text/markdown files
autocmd BufNewFile,BufRead *.txt,*.md setlocal wrap

" Indicator chars
set list
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
set showbreak=↪\

" Joining lines
set formatoptions+=j " Delete comment char when joining commented lines
set nojoinspaces     " Use only 1 space after "." when joining lines, not 2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Switch to the next buffer
nmap <leader>bn :bn<cr>

" Or the previous buffer
nmap <leader>bp :bp<cr>

" Delete the current buffer (preserving the window)
nmap <leader>bd :bd<cr>

" Delete all the open buffers
nmap <leader>bda :1,1000 bd<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle the NERDTree window
map <leader>t :NERDTreeToggle<cr>

" Open NERDTree automatically when vim starts up if no files were specified
"autocmd vimenter * if !argc() | NERDTree | endif

" Close vim if the only window open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Interactive mode for vim-easy-align (repeats with ., etc.)
vmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Toggle the MiniBufExplorer window
map <leader>ls :MBEToggle<cr>:MBEFocus<cr>

" Focus on the MiniBufExplorer window
map <leader>f :MBEFocus<cr>

" Open a new scratch buffer from vim-scratch
nmap <leader>s  :Scratch<cr>
nmap <leader>ss :Sscratch<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
"map <leader>pp :setlocal paste!<cr>

" Saves with sudo in case you've forgotten
cmap w!! %!sudo tee > /dev/null %

" Alias the unnamed register to the + register (X Windows clipboard)
set clipboard=unnamedplus


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle relative/absolute numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <F9> :call NumberToggle()<cr>
