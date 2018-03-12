.vim
====

My personal vim/nvim settings

Installation
------------

First clone the repo inside your home directory:

```console
$ git clone git@github.com:elyezer/.vim.git
```

Next, if you are running vim, run the following:

```console
$ ln -s ~/.vim/vimrc ~/.vimrc
$ vim
```

If you are running nvim (Neovim), run the following:

```console
$ mkdir -p ~/.config/nvim
$ ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
$ nvim
```

When vim/nvim starts for the first time, it will install vim-plug and, after
loading, will run `:PlugInstall` to install all plugins. Most of the plugins
will be loaded after quitting the PlugInstall window, but it is recommended to
restart vim/nvim to make sure everything is loaded.
