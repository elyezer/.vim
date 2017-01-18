.vim
====

My personal vim settings

Installation
------------

To install just clone the repo inside you home directory and execute the
commands below. If you already have a .vim directory in your home directory
remove or rename it.

```
git clone git@github.com:elyezer/.vim.git
ln -s ~/.vim/vimrc ~/.vimrc
vim
```

When vim starts for the first time, it will install vim-plug and, after
loading, will run `:PlugInstall` to install all plugins. Most of the plugins
will be loaded after quitting the PlugInstall window, but it is recommended to
restart vim to make sure everything is loaded.
