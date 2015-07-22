.vim
====

My personal vim settings

Installation
------------

To install just clone the repo inside you home directory and execute the
commands below. If you already have a .vim directory in your home folder remove
or rename it.

```
git clone git@github.com:elyezer/.vim.git
ln -s ~/.vim/vimrc ~/.vimrc
vim
```

When vim starts, it will clone the NeoBundle repository and will ask you to
install the bundles. Answer 'y' in order to get the bundles.

Is recommended that after installing the bundles for the first time to quit vim
and run it again because there are some bundles that load some stuff during the
vim startup.
