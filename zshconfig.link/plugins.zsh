#!/usr/bin/env zsh

PLUGIN_DIR=${0:a:h}/plugins

# Plugins should be found in .zshconfig/plugins
# - Each one is sourced from <plugin_name>/<plugin_name>.plugin.zsh (or plugin.zsh)
# - Directories including _<plugin_name> are also added to fpath for autocompletion help
# oh-my-zsh plugins found here: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    colorize  # requires tool pygments from brew; source: copied from oh-my-zsh
    fasd      # minor changes, added default aliases; source: copied from oh-my-zsh
    fzf       # special install steps in brew.sh; must copy ~/.fsf.zsh to plugins dir
    history
    nmap      # source: copied from oh-my-zsh
    ripgrep   # source: copied from oh-my-zsh

    zsh-syntax-highlighting   # should be last; source: https://github.com/zsh-users/zsh-syntax-highlighting)
)


# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  if [ -f $PLUGIN_DIR/$plugin/$plugin.plugin.zsh ]; then
    source $PLUGIN_DIR/$plugin/$plugin.plugin.zsh
  elif [ -f $PLUGIN_DIR/$plugin/$plugin.zsh ]; then
    source $PLUGIN_DIR/$plugin/$plugin.zsh
  elif [ -f $PLUGIN_DIR/$plugin/_$plugin ]; then
    continue
  else
    echo "warning: zsh plugin '$plugin' not found"
  fi
done

unset PLUGIN_DIR plugins
