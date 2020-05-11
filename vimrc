"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Get the shell sorted out properly
set shell=bash
set shellcmdflag=-ic
let g:is_bash=1

" Autocomplete menu
set wildmenu
set wildmode=longest,list
set wildignore+=*.a,*.o
set wildignore+=.git,.svn,.hg


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
:nnoremap <Leader><CR> :nohlsearch<CR>

" No damn beeping
set noerrorbells visualbell t_vb=


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
" Turn backup off, since most stuff is version controlled anyway
set nobackup
set nowb
set noswapfile

" Recognize markdown files
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Save more easily
" NOTE: disabled because this messes with other mappings and is annoying
"map <C-s> :w<CR>

" Save undo history
set undofile
set undodir=~/.vim/.undo


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

" We want tabs for the following though
autocmd FileType go set noexpandtab
autocmd BufNewFile,BufRead Makefile,Makefile.*,*.mk setlocal noexpandtab

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
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Switch to the next buffer
nmap <Leader>bn :bn<CR>

" Or the previous buffer
nmap <Leader>bp :bp<CR>

" Delete the current buffer (preserving the window)
nmap <Leader>bd :bd<CR>

" Delete all the open buffers
nmap <Leader>bda :1,1000 bd<CR>

" Quickfix window
nmap <Leader>qo :copen<CR>
nmap <Leader>qc :cclose<CR>
nmap <Leader>qn :cnext<CR>
nmap <Leader>qp :cprevious<CR>
" Local window
nmap <Leader>lo :copen<CR>
nmap <Leader>lc :cclose<CR>
nmap <Leader>ln :cnext<CR>
nmap <Leader>lp :cprevious<CR>

" Manage buffers
nnoremap <Space> :ls<CR>:b<Space>
nnoremap <Leader>bb :ls<CR>:b<Space>
nnoremap <Leader>bv :ls<CR>:vsp<Space>\|<Space>b<Space>
nnoremap <Leader>bs :ls<CR>:sp<Space>\|<Space>b<Space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic should use JSHint for JavaScript debugging
let g:syntastic_javascript_checkers = ['jshint']

" Interactive mode for vim-easy-align
" TIP: press <C-x> for regex, or :EasyAlign /regex/
vmap <Enter>   <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Easymotion
"map <Leader><Leader> <Plug>(easymotion-prefix)
" Move to char
map  <Leader>c <Plug>(easymotion-bd-f)
nmap <Leader>c <Plug>(easymotion-overwin-f)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Ctrl+P
nmap <Leader>pp :CtrlP<CR>
nmap <Leader>pb :CtrlPBuffer<CR>
nmap <Leader>pm :CtrlPMixed<CR>
" Recognize project root
let g:ctrlp_root_markers = ['.git', '.hg', '.svn', '.idea']
" Ignore files/directories (including those listed in .gitignore)
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Mundo (undo visualization)
map U :MundoToggle<CR>

" VimCompletesMe
let b:vcm_tab_complete = 'omni'
autocmd FileType vim let b:vcm_tab_complete = 'vim'

" Grepper
let g:grepper = {}
let g:grepper.tools = ['git', 'ag', 'grep']
nnoremap <Leader>g :Grepper -tool ag<CR>
nnoremap <Leader>G :Grepper -tool ag -buffers<CR>
nmap gs  <Plug>(GrepperOperator)
xmap gs  <Plug>(GrepperOperator)
" Search for word under cursor
nnoremap <leader>* :Grepper -tool ag -cword -noprompt<CR>

" Jedi python
let g:jedi#goto_command = '<Leader>jg'
let g:jedi#goto_definitions_command = '<Leader>jd'
let g:jedi#goto_assignments_command = '<Leader>ja'
let g:jedi#documentation_command = 'K'
let g:jedi#usages_command = '<Leader>ju'
let g:jedi#rename_command = '<Leader>jr'
let g:jedi#goto_stubs_command = ''


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

" Display git info (with Fugitive)
"set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
"set statusline+=%#error#
"set statusline+=%{StatuslineTabWarning()}
"set statusline+=%*

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
"map <Leader>pp :setlocal paste!<CR>

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

nnoremap <F9> :call NumberToggle()<CR>
