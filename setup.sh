cd
# git clone https://github.com/benjaminrh/dotvim .vim
cd .vim
git submodule init
git submodule update
cd ..
ln -s .vim/.vimrc
