#!/usr/bin/env zsh

# Installs Vim plugin manager, Vundle

if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall
