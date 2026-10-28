.vim
====

My personal Neovim settings

Installation
------------

First clone the repo inside your home directory:

```console
$ git clone git@github.com:elyezer/.vim.git ~/.vim
```

Next, run the following:

```console
$ ln -s ~/.vim ~/.config/nvim
$ nvim
```

This configuration requires Neovim 0.12 or newer and uses the built-in
`vim.pack` plugin manager. When nvim starts for the first time, it will install
the plugins listed in `lua/elyezer/plugins.lua`. Restart nvim afterward to make
sure everything is loaded.

To update plugins, run:

```console
:lua vim.pack.update()
```

Plugin revisions are pinned in `nvim-pack-lock.json`, so a fresh clone
installs the exact versions this configuration was last tested with.
After updating, review the changes to the lock file and commit them
once everything is working.
