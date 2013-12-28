.vim
====

My personal vim settings

Installation
------------

To install just clone the repo inside you home directory and execute the commands below. If you already have a .vim directory in your home folder remove or rename it.

```
git clone git@github.com:elyezer/.vim.git
ln -s ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
```

After running the commands, next time you start vim it will be already configured.
