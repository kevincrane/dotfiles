#!/usr/bin/env zsh

# Install and initialize any plugin submodules for ZSH
git submodule init
git pull --recurse-submodules

# Install fasd; configured in plugin/fasd
brew install fasd

# Install fzf
if [[ ! -d "/usr/local/opt/fzf" ]]; then
  brew install fzf
  $BREW_PREFIX/opt/fzf/install
  mkdir -p $DOTFILE_REPO/zsh/plugins/fzf
  mv ~/.fzf.zsh $DOTFILE_REPO/zsh/plugins/fzf/fzf.plugin.zsh
  rm -f ~/.fzf.bash  # Only if still using ZSH exclusively
fi
