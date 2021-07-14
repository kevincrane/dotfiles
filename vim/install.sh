#!/usr/bin/env zsh

# Installs Vim plugin manager, Vundle

echo "=> Installing Vundle"
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
echo "=> Updating Vundle plugins"
vim +PluginInstall +qall < /dev/tty
echo "=> Done installing Vim and Vundle"
