# Installation
1.  Clone this repository somewhere
2.  Symlink the repository to `~/.vim/`
3.  Create a file at `~/.vimrc` with the following contents:

    `source path/to/repo/.vimrc`

4.  If you're using Neovim, repeat the above (replacing `.vimrc` with `.nvimrc`)

# Included Plugins
Firstly, note that there are three folders named `bundle-*` in the repository.

The first (`bundle`) is for platform-independend plugins, which is most of them.

Plugins with platform-dependent components (e.g., YouCompleteMe/Clighter) can be found in the `bundle-darwin` and
`bundle-linux` folders, although given that they seem to be causing a significant performance hit at the moment, I've
removed them for now.

At the moment, the following plugins are included:

  - ag.vim
  - ctrlp.vim
  - twilight256
  - vim-bufferline
  - vim-commentary
  - vim-easymotion
  - vim-fish
  - vim-fugitive
  - vim-go
  - vim-hy
  - vim-nasm
  - vim-peekaboo
  - vim-polyglot
  - vim-signature
  - vim-swift
  - vim-toml
 
# Key bindings
## Leader Key
The leader key is `,` (comma)

## EasyMotion
Some of the default search bindings (`/`, `n`, and `N`) has been replaced with EasyMotion commands.
By default, EasyMotion is bound to `,,` (`<leader><leader>`)

## Split pane management
This one's mnemonic: use `<C-w>` to enter window management mode, then `<C-DIRECTION>` to create a new pane in the
requested direction. Direction should be one of [`h`, `j`, `k`, `l`].

## CtrlP
CtrlP (a fuzzy file-finder) is currently bound to `,e`. Additionally, CtrlP's buffer mode is bound to `,b`.


