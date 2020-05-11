# vim
My vim configuration. Attempting to remain reasonably lightweight and bloat-free.


## Install
Open a terminal and run the following:

    cd ~
    git clone https://github.com/BenjaminRH/dotvim.git .vim --recursive
    ln -s .vim/vimrc .vimrc


## Plugins
A list of plugins used. Plugin specific settings are located in the vimrc in the "Plugin settings" section.

 * [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) - Fuzzy search files/buffers/tags/etc. with `CTRL+P`
 * [jedi-vim](https://github.com/davidhalter/jedi-vim) - Bindings for the Jedi Python library
 * [quickfix-reflector.vim](https://github.com/stefandtw/quickfix-reflector.vim) - Edit files from the quickfix window
 * [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim) - Split/join lines of code in different languages with `gS`/`gJ`
 * [syntastic](https://github.com/vim-syntastic/syntastic) - Syntax checking for different languages
 * [targets.vim](https://github.com/wellle/targets.vim) - Adds additional vim targets, such as commas, quotes, tags, etc.
 * [tcomment](https://github.com/tomtom/tcomment_vim) - Comment/uncomment lines of code in different languages with `gc`
 * [vim-abolish](https://github.com/tpope/vim-abolish) - Better search/replace with `:S` including case-preserving replaces, unix-style `{a,b}` expansion, etc. Also coerce cases with `cr<X>` (`<X>` is s for snake, c for camel, m for mixed, etc.)
 * [vim-buftabline](https://github.com/ap/vim-buftabline) - Display open buffers in tab line
 * [vim-clang](https://github.com/justmao945/vim-clang) - Uses Clang to parse C/C++ files for autocompletion
 * [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) - Solarized colorscheme and better terminal support for it
 * [vim-easy-align](https://github.com/junegunn/vim-easy-align) - Easily align lines of text however you want
 * [vim-easymotion](https://github.com/easymotion/vim-easymotion) - Jump to any word or character on screen with `,,w`/`,,c`
 * [vim-easyoperator-line](https://github.com/haya14busa/vim-easyoperator-line) - Extends `vim-easymotion` to jump to lines with `,,l`
 * [vim-grepper](https://github.com/mhinz/vim-grepper) - Nice wrapper for grep operations using external tool (tries ag, ack, grep, etc.)
 * [vim-mundo](https://github.com/simnalamburt/vim-mundo) - Undo tree visualizer
 * [vim-pathogen](https://github.com/tpope/vim-pathogen) - Plugin manager for vim
 * [vim-polyglot](https://github.com/sheerun/vim-polyglot) - Syntax support for tons of languages/filetypes
 * [vim-repeat](https://github.com/tpope/vim-repeat) - Allows many things to be repeated with vim's `.` command
 * [vim-surround](https://github.com/tpope/vim-surround) - Add/remove braces/parens/etc. around objects
 * [vim-visual-star-search](https://github.com/nelstrom/vim-visual-star-search) - Support star/hash search in visual mode
 * [VimCompletesMe](https://github.com/ajh17/VimCompletesMe) - Lightweight tab-completion


## Dependencies
There are some optional external projects that plugins can take advantage of, although currently none of these are required.

 * [jedi](https://pypi.org/project/jedi/) - Python static analysis tool. Used by `jedi-vim` for Python language autocompletion
 * [clang](https://clang.llvm.org/) - C compiler. Used by `vim-clang` for C-family language autocompletion
 * [ag](https://github.com/ggreer/the_silver_searcher) - Better ack/grep. Used by `vim-grepper` to search, if available


## Manage plugins
All plugins are git submodules, managed in vim by the Pathogen plugin.

### Add plugin

    git submodule add git@github.com:user/vim-plugin.git bundle/vim-plugin

### Remove plugin
If the submodule has been initialized:

    git submodule deinit -f bundle/vim-plugin
    rm -rf .git/modules/bundle/vim-plugin

Remove the submodule:

    git rm -f bundle/vim-plugin

Remove the entry from the .gitmodules file, then commit it:

    sed -i -e '/submodule "bundle\/vim-plugin"/,+2d' .gitmodules
    git add .gitmodules
    git commit -m "Removed vim-plugin"
