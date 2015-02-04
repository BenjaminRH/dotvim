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
"    -> Status line
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

" Get the shell sorted out properly
set shell=bash
set shellcmdflag=-ic
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

" Add non-relative line numbers where the current line displays the actual line number
set number
set norelativenumber

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
:nnoremap <leader><cr> :nohlsearch<cr>

" Hide some GUI crap
set guioptions-=m " No menu bar
set guioptions-=T " No toolbar
set guioptions-=r " No scrollbar (right)
set guioptions-=R " No scrollbar (right, on vertical split windows)
set guioptions-=l " No scrollbar (left)
set guioptions-=L " No scrollbar (left, on vertical split windows)
set guioptions-=b " No scrollbar (bottom)

" No damn beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" Set the colorscheme
colorscheme solarized

" Set the colorscheme background
if has('gui_running')
    set background=light
else
    " Make the Solarized colorscheme work properly in decent terminals
    set background=dark
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
endif

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

" Save more easily
map <C-s> :w<CR>


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

" Go (golang) specific indentation settings
autocmd FileType go set noexpandtab

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
map <leader>d :NERDTreeToggle<cr>

" Open NERDTree automatically when vim starts up if no files were specified
"autocmd vimenter * if !argc() | NERDTree | endif

" DETECT INDENT
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
autocmd BufReadPost * :DetectIndent " Run automatically when opening a file

" Use TernJS for autocompleting JavaScript
autocmd FileType javascript setlocal omnifunc=tern#Complete

" Syntastic should use JSHint for JavaScript debugging
let g:syntastic_javascript_checkers = ['jshint']

" Close vim if the only window open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Add Mustache/Handlebars tag autocompletion and stuff (abbreviations)
let g:mustache_abbreviations = 1

" Supertabs should decide which completion method to use automatically
" let g:SuperTabDefaultCompletionType = 'context' " Or '<C-x><C-o>' for omni completion
" let g:SuperTabClosePreviewOnPopupClose = 1 " And don't leave that annoying preview window open

" YouCompleteMe automatically close annoying completion preview window open
let g:ycm_autoclose_preview_window_after_completion = 1

" Interactive mode for vim-easy-align (repeats with ., etc.)
vmap <Enter>   <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Automatically close html-style tags
autocmd FileType xhtml,xml,html,markdown,blade source ~/.vim/bundle/html-autoclosetag/ftplugin/html_autoclosetag.vim

" Toggle the MiniBufExplorer window
map <leader>ls :MBEToggle<cr>:MBEFocus<cr>

" Focus on the MiniBufExplorer window
map <leader>f :MBEFocus<cr>

" Toggle the Tagbar
nmap <leader>t :TagbarToggle<cr>

" VIM-GO SETTING:
" Turn off auto-installation of requried binaries
let g:go_disable_autoinstall = 1
" Import the package under the cursor
au FileType go nmap <Leader>gi <Plug>(go-import)
" Open the relevant Godoc for the word under the cursor
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gvd <Plug>(go-doc-vertical)
" Go run, build, and test
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
" Go def
au FileType go nmap <Leader>gf <Plug>(go-def-split)
au FileType go nmap <Leader>gvf <Plug>(go-def-vertical)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"statusline setup
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
"map <leader>pp :setlocal paste!<cr>

" Saves with sudo in case you've forgotten
cmap w!! %!sudo tee > /dev/null %

" Alias the unnamed register to the + register (X Windows clipboard)
"set clipboard=unnamedplus " Linux
set clipboard=unnamed " Mac

" Find TODO comments in the current working directory
noremap <Leader>todo :noautocmd vimgrep /TODO/j **/*.*<CR>:cw<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle relative/absolute numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <F9> :call NumberToggle()<cr>
