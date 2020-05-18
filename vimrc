"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Ex mode related
"    -> Moving around, tabs, windows and buffers
"    -> Plugin settings
"    -> Status line
"    -> Netrw
"    -> Folding
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

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" Set the leader
let mapleader = ","

" Get the shell sorted out properly
set shell=bash
set shellcmdflag=-ic
let g:is_bash = 1

" Autocomplete menu
set wildmenu
set wildmode=list:full
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

" Add relative line numbers where the current line displays the actual line number
set number
set relativenumber

" Always show current position
set ruler

" Show partial command at bottom of screen
set showcmd

" Show current mode at bottom of screen
set showmode

" Always display status bar
set laststatus=2

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned (background buffers)
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results
set hlsearch

" Match-as-you-type searching
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
nnoremap <Leader><CR> :nohlsearch<CR>

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

" Set utf8 as standard encoding
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
augroup filetype_markdown
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

" Save more easily
" NOTE: disabled because this messes with other mappings and is annoying
"map <C-s> :w<CR>

" Save undo history persistently
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
set nolinebreak
set textwidth=0

" Enable smart indent
filetype plugin indent on

" Auto indent
set autoindent

" Do not wrap lines
set nowrap

" But wrap lines for text/markdown files
augroup filetype_markdown_wrap_lines
    autocmd!
    autocmd BufNewFile,BufRead *.txt,*.md setlocal wrap
augroup END

" We want tabs for the following though
augroup filetype_noexpandtab
    autocmd!
    autocmd FileType go set noexpandtab
    autocmd BufNewFile,BufRead Makefile,Makefile.*,*.mk setlocal noexpandtab
augroup END

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

" Make '.' work in visual mode like it does in normal mode
vnoremap . :normal.<CR>

" J/K to move selected lines down/up (and automatically reindent + reselect)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ex mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emacs-like Control+A mapping
cnoremap <C-a> <Home>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Switch CWD to the directory of the open buffer
noremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Return to last edit position when opening files
augroup return_last_edit_position
    autocmd!
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
augroup END

" Remember info about open buffers on close
set viminfo^=%

" Switch to the next buffer
nnoremap <Leader>n :bn<CR>

" Switch to the previous buffer
nnoremap <Leader>p :bp<CR>

" Delete all the open buffers
nnoremap <Leader>bda :1,.+1000 bd<CR>

" Quickfix window
nnoremap <Leader>qo :copen<CR>
nnoremap <Leader>qc :cclose<CR>
nnoremap <Leader>qn :cnext<CR>
nnoremap <Leader>qp :cprevious<CR>
nnoremap <Leader>qf :cfirst<CR>
nnoremap <Leader>ql :clast<CR>
" Local window
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>lc :lclose<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprevious<CR>
nnoremap <Leader>lf :lfirst<CR>
nnoremap <Leader>ll :llast<CR>

" Manage buffers
nnoremap <Space> :ls<CR>:b<Space>
nnoremap <Leader>bb :ls<CR>:b<Space>
nnoremap <Leader>bd :ls<CR>:bd<Space>
nnoremap <Leader>bv :ls<CR>:vsp<Space>\|<Space>b<Space>
nnoremap <Leader>bs :ls<CR>:sp<Space>\|<Space>b<Space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable ALE by default
let g:ale_enabled = 0
" But when ALE is disabled, lint when all these things happen
let g:ale_lint_on_text_changed = 'normal' " 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

" Navigation between ALE errors/warnings
nnoremap <Leader>sn :ALENext<CR>
nnoremap <Leader>sp :ALEPrevious<CR>
nnoremap <Leader>sf :ALEFirst<CR>
nnoremap <Leader>sl :ALELast<CR>
nnoremap <Leader>sd :ALEDetail<CR>

" Enable/disable linting
nnoremap <Leader>sc :ALEEnable<CR>
nnoremap <Leader>sr :ALEDisable<CR>

augroup ale_linting_plugin
    autocmd!
    " Wrap buffer for ALE preview window, so we can see entire message
    autocmd FileType ale-preview setlocal wrap
augroup END

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
nnoremap <Leader>fp :CtrlP<CR>
nnoremap <Leader>fb :CtrlPBuffer<CR>
nnoremap <Leader>fm :CtrlPMixed<CR>
" Recognize project root
let g:ctrlp_root_markers = ['.git', '.hg', '.svn', '.idea']
" Ignore files/directories (including those listed in .gitignore)
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Mundo (undo visualization)
noremap U :MundoToggle<CR>

" VimCompletesMe
"let b:vcm_tab_complete='omni'
augroup filetype_vim_autocomplete
    autocmd!
    autocmd FileType vim let b:vcm_tab_complete='vim'
augroup END

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
let g:jedi#goto_command = '<Leader>pg'
let g:jedi#goto_definitions_command = '<Leader>pd'
let g:jedi#goto_assignments_command = '<Leader>pa'
let g:jedi#documentation_command = 'K'
let g:jedi#usages_command = '<Leader>pu'
let g:jedi#rename_command = '<Leader>pr'
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

set statusline+=%#warningmsg#
set statusline+=%{ALEStatus()}
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

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name=synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

function! ALEStatus() abort
    if !g:ale_enabled
        return ''
    endif

    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'ALE: OK' : printf(
    \   'ALE: E=%d, W=%d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List style should be an expandable tree
let g:netrw_liststyle = 3

" Don't display quick-help banner
let g:netrw_banner = 0

" In which window should the file open
"let g:netrw_browse_split=4 " Previous window
let g:netrw_browse_split = 0 " netrw window

" Set netrw window size to percent of page
let g:netrw_winsize = 25

" Toggle netrw as a vertical split on the far left
"nnoremap <Leader>d :Lexplore<CR>
"vnoremap <Leader>d :Lexplore<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable folding
"set foldenable

" Open most of the folds by default (0 would be all)
set foldlevelstart=10

" Max nested folds
set foldnestmax=10

" Fold control method (manual/indent/syntax)
set foldmethod=indent

" Extra column next to line numbers, indicating fold status
"set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
"noremap <Leader>pp :setlocal paste!<CR>

" Saves with sudo in case you've forgotten
cnoremap w!! %!sudo tee > /dev/null %

" Alias the unnamed register to the + register (X Windows clipboard)
"set clipboard=unnamedplus " Linux
set clipboard=unnamed " Mac

" Find TODO comments in the current working directory
noremap <Leader>todo :noautocmd vimgrep /TODO/j **/*.*<CR>:cw<CR>

" Display [x/y] in bottom right of screen when searching
set shortmess-=S

" Dictionary for spell checking and dictionary autocomplete
set dictionary+=/usr/share/dict/words

" The 'isfname' setting determines which characters are considered part of a path (for 'gf' or file autocomplete)
" Here we remove a few common prefixes for easier path autocompletion
set isfname-==
set isfname-='
set isfname-=\"
set isfname-=(
set isfname-=<


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

" Auto number indexes in array from 0-n
" Example:
"     FROM:
"         foo[] = 'a';
"         foo[] = 'b';
"         foo[] = 'c';
"     TO:
"         foo[0] = 'a';
"         foo[1] = 'b';
"         foo[2] = 'c';
"
function! AutoNumberIndexes() range
    let i=0 | '<,'>g/\[\d*\]/ s/\[\d*\]/\='['.i.']'/ | let i+=1
    " NOTE: we don't support multiple array assignments on each line, because
    " adding /g flag to the substitution wouldn't increment i multiple times.
    " There are tricks, e.g. adding elements to an array in the substitution
    " replacement expression, but whatever.
endfunc

vnoremap <Leader>i :call AutoNumberIndexes()<CR>
