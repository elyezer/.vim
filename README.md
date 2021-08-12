.vim
====

My personal Neovim settings

Installation
------------

First clone the repo inside your home directory:

```console
$ git clone git@github.com:elyezer/.vim.git
```

Next, run the following:

```console
$ mkdir -p ~/.config/nvim
$ ln -s ~/.vim/init.vim ~/.config/nvim/init.vim
$ nvim
```

When nvim starts for the first time, it will install vim-plug and, after
loading, will run `:PlugInstall` to install all plugins. Most of the plugins
will be loaded after quitting the PlugInstall window, but it is recommended to
restart nvim to make sure everything is loaded.
