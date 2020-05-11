# vim
My vim configuration. Attempting to remain reasonably lightweight and bloat-free.


## Install
Open a terminal and run the following:

    cd ~
    git clone https://github.com/BenjaminRH/dotvim.git .vim --recursive
    ln -s .vim/vimrc .vimrc


## Plugins
A list of plugins used. Plugin specific settings are located in the vimrc in the "Plugin settings" section.

 * *completor.vim* - Autocompletion framework (supports Jedi, Clang, etc.)
 * *completor-tmux* - Extends `completor.vim` to add open tmux windows as a completion source
 * *ctrlp.vim* - Fuzzy search files/buffers/tags/etc. with `CTRL+P`
 * *splitjoin.vim* - Split/join lines of code in different languages with `gS`/`gJ`
 * *syntastic* - Syntax checking for different languages
 * *targets.vim* - Adds additional vim targets, such as commas, quotes, tags, etc.
 * *tcomment* - Comment/uncomment lines of code in different languages with `gc`
 * *vim-abolish* - Better search/replace with `:S` including case-preserving replaces, unix-style `{a,b}` expansion, etc. Also coerce cases with `cr<X>` (`<X>` is s for snake, c for camel, m for mixed, etc.)
 * *vim-buftabline* - Display open buffers in tab line
 * *vim-colors-solarized* - Solarized colorscheme and better terminal support for it
 * *vim-easy-align* - Easily align lines of text however you want
 * *vim-easymotion* - Jump to any word or character on screen with `,,w`/`,,c`
 * *vim-easyoperator-line* - Extends `vim-easymotion` to jump to lines with `,,l`
 * *vim-pathogen* - Plugin manager for vim
 * *vim-polyglot* - Syntax support for tons of languages/filetypes
 * *vim-repeat* - Allows many things to be repeated with vim's `.` command
 * *vim-surround* - Add/remove braces/parens/etc. around objects
 * *vim-visual-star-search* - Support star/hash search in visual mode


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
